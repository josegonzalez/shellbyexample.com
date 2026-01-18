// Clipboard functionality for Shell by Example
(function() {
    'use strict';

    // Initialize copy buttons when DOM is ready
    document.addEventListener('DOMContentLoaded', function() {
        var copyButtons = document.querySelectorAll('.copy-btn');

        copyButtons.forEach(function(button) {
            button.addEventListener('click', function() {
                var targetId = button.getAttribute('data-target');
                var targetElement = document.getElementById(targetId);

                if (!targetElement) {
                    return;
                }

                // Get the raw code from data attribute, or fall back to text content
                var code = targetElement.getAttribute('data-code') || targetElement.textContent;

                copyToClipboard(code, button);
            });
        });
    });

    function copyToClipboard(text, button) {
        // Use the modern Clipboard API if available
        if (navigator.clipboard && navigator.clipboard.writeText) {
            navigator.clipboard.writeText(text).then(function() {
                showCopiedFeedback(button);
            }).catch(function() {
                fallbackCopy(text, button);
            });
        } else {
            fallbackCopy(text, button);
        }
    }

    function fallbackCopy(text, button) {
        // Fallback for older browsers
        var textArea = document.createElement('textarea');
        textArea.value = text;
        textArea.style.position = 'fixed';
        textArea.style.left = '-9999px';
        textArea.style.top = '0';
        document.body.appendChild(textArea);
        textArea.focus();
        textArea.select();

        try {
            document.execCommand('copy');
            showCopiedFeedback(button);
        } catch (err) {
            console.error('Failed to copy text:', err);
        }

        document.body.removeChild(textArea);
    }

    function showCopiedFeedback(button) {
        var originalText = button.textContent;
        button.textContent = 'Copied!';
        button.classList.add('copied');

        setTimeout(function() {
            button.textContent = originalText;
            button.classList.remove('copied');
        }, 2000);
    }
})();
