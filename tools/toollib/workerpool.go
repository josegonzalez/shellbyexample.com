package toollib

import "sync"

// WorkerPool manages parallel job processing with configurable workers.
type WorkerPool[T any] struct {
	Jobs       []string
	NumWorkers int
	ProcessFn  func(job string) T
}

// Run executes all jobs using the worker pool and returns results via a callback.
// The callback is called for each completed job with the result.
func (wp *WorkerPool[T]) Run(onResult func(result T)) {
	total := len(wp.Jobs)
	if total == 0 {
		return
	}

	jobs := make(chan string, total)
	results := make(chan T, total)

	// Start workers
	var wg sync.WaitGroup
	for i := 0; i < wp.NumWorkers; i++ {
		wg.Go(func() {
			for job := range jobs {
				results <- wp.ProcessFn(job)
			}
		})
	}

	// Send all jobs
	for _, job := range wp.Jobs {
		jobs <- job
	}
	close(jobs)

	// Close results channel when all workers complete
	go func() {
		wg.Wait()
		close(results)
	}()

	// Collect results
	for result := range results {
		onResult(result)
	}
}
