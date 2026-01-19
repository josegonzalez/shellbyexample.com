package toollib

import (
	"sort"
	"sync"
	"testing"
)

func TestWorkerPool_Basic(t *testing.T) {
	jobs := []string{"a", "b", "c", "d", "e"}

	pool := WorkerPool[string]{
		Jobs:       jobs,
		NumWorkers: 2,
		ProcessFn: func(job string) string {
			return job + "_processed"
		},
	}

	var results []string
	var mu sync.Mutex

	pool.Run(func(result string) {
		mu.Lock()
		results = append(results, result)
		mu.Unlock()
	})

	if len(results) != len(jobs) {
		t.Errorf("got %d results, want %d", len(results), len(jobs))
	}

	// Sort for deterministic comparison
	sort.Strings(results)
	expected := []string{"a_processed", "b_processed", "c_processed", "d_processed", "e_processed"}
	for i, r := range results {
		if r != expected[i] {
			t.Errorf("results[%d] = %q, want %q", i, r, expected[i])
		}
	}
}

func TestWorkerPool_EmptyJobs(t *testing.T) {
	pool := WorkerPool[string]{
		Jobs:       []string{},
		NumWorkers: 2,
		ProcessFn: func(job string) string {
			return job
		},
	}

	callCount := 0
	pool.Run(func(result string) {
		callCount++
	})

	if callCount != 0 {
		t.Errorf("callback called %d times for empty jobs, want 0", callCount)
	}
}

func TestWorkerPool_SingleWorker(t *testing.T) {
	jobs := []string{"1", "2", "3"}

	pool := WorkerPool[int]{
		Jobs:       jobs,
		NumWorkers: 1,
		ProcessFn: func(job string) int {
			return len(job)
		},
	}

	var results []int
	pool.Run(func(result int) {
		results = append(results, result)
	})

	if len(results) != 3 {
		t.Errorf("got %d results, want 3", len(results))
	}

	// All results should be 1 (length of "1", "2", "3")
	for i, r := range results {
		if r != 1 {
			t.Errorf("results[%d] = %d, want 1", i, r)
		}
	}
}

func TestWorkerPool_ManyWorkers(t *testing.T) {
	jobs := []string{"a", "b"}

	pool := WorkerPool[string]{
		Jobs:       jobs,
		NumWorkers: 10, // More workers than jobs
		ProcessFn: func(job string) string {
			return job
		},
	}

	var results []string
	var mu sync.Mutex

	pool.Run(func(result string) {
		mu.Lock()
		results = append(results, result)
		mu.Unlock()
	})

	if len(results) != 2 {
		t.Errorf("got %d results, want 2", len(results))
	}
}

func TestWorkerPool_StructResult(t *testing.T) {
	type Result struct {
		Job    string
		Length int
	}

	jobs := []string{"hello", "world", "test"}

	pool := WorkerPool[Result]{
		Jobs:       jobs,
		NumWorkers: 2,
		ProcessFn: func(job string) Result {
			return Result{Job: job, Length: len(job)}
		},
	}

	var results []Result
	var mu sync.Mutex

	pool.Run(func(result Result) {
		mu.Lock()
		results = append(results, result)
		mu.Unlock()
	})

	if len(results) != 3 {
		t.Errorf("got %d results, want 3", len(results))
	}

	// Verify each result has correct length
	for _, r := range results {
		if r.Length != len(r.Job) {
			t.Errorf("result for %q has length %d, want %d", r.Job, r.Length, len(r.Job))
		}
	}
}

func TestWorkerPool_Concurrency(t *testing.T) {
	// Test that workers actually run concurrently
	jobs := make([]string, 100)
	for i := range jobs {
		jobs[i] = string(rune('a' + i%26))
	}

	pool := WorkerPool[int]{
		Jobs:       jobs,
		NumWorkers: 4,
		ProcessFn: func(job string) int {
			return len(job)
		},
	}

	resultCount := 0
	var mu sync.Mutex

	pool.Run(func(result int) {
		mu.Lock()
		resultCount++
		mu.Unlock()
	})

	if resultCount != len(jobs) {
		t.Errorf("got %d results, want %d", resultCount, len(jobs))
	}
}
