<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Password Strength Analyzer</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .animate-fade-in {
            animation: fadeIn 0.5s ease-out;
        }
        .strength-WEAK { background: linear-gradient(135deg, #ef4444, #dc2626); }
        .strength-MEDIUM { background: linear-gradient(135deg, #f59e0b, #d97706); }
        .strength-STRONG { background: linear-gradient(135deg, #10b981, #059669); }
    </style>
</head>
<body class="bg-gradient-to-br from-gray-900 via-gray-800 to-gray-900 min-h-screen">
    <div class="container mx-auto px-4 py-12">
        <!-- Header -->
        <div class="text-center mb-12 animate-fade-in">
            <div class="inline-block p-3 bg-gradient-to-r from-purple-500 to-pink-500 rounded-2xl shadow-lg mb-4">
                <svg class="w-12 h-12 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"></path>
                </svg>
            </div>
            <h1 class="text-5xl font-bold text-white mb-4">Password Strength Analyzer</h1>
            <p class="text-gray-300 text-lg">Check your password security and get improvement suggestions</p>
        </div>

        <!-- Main Card -->
        <div class="max-w-2xl mx-auto bg-white/10 backdrop-blur-lg rounded-2xl shadow-2xl p-8 animate-fade-in">
            <!-- Password Input -->
            <div class="mb-8">
                <label class="block text-gray-200 text-sm font-semibold mb-2">
                    Enter Your Password
                </label>
                <div class="relative">
                    <input type="password" 
                           id="passwordInput" 
                           class="w-full px-4 py-3 bg-white/20 border border-gray-500 rounded-lg text-white placeholder-gray-400 focus:outline-none focus:border-purple-500 transition-all text-lg"
                           placeholder="Type or paste your password here...">
                    <button type="button" 
                            id="togglePassword"
                            class="absolute right-3 top-1/2 transform -translate-y-1/2 text-gray-400 hover:text-white transition">
                        <svg id="eyeIcon" class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path>
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"></path>
                        </svg>
                    </button>
                </div>
            </div>

            <!-- Analyze Button -->
            <button id="analyzeBtn" 
                    class="w-full bg-gradient-to-r from-purple-500 to-pink-500 text-white font-bold py-4 px-6 rounded-lg hover:opacity-90 transition-all transform hover:scale-[1.02] disabled:opacity-50 disabled:cursor-not-allowed text-lg">
                Analyze Password
            </button>

            <!-- Loading Indicator -->
            <div id="loadingIndicator" class="hidden mt-4 text-center">
                <div class="inline-block animate-spin rounded-full h-8 w-8 border-b-2 border-purple-500"></div>
                <p class="text-gray-300 mt-2">Analyzing your password...</p>
            </div>

            <!-- Error Message -->
            <div id="errorMessage" class="hidden mt-4 p-3 rounded-lg bg-red-500/20 border border-red-500/50">
                <div class="flex items-center space-x-2">
                    <svg class="w-5 h-5 text-red-400 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                    </svg>
                    <span id="errorText" class="text-red-300 text-sm"></span>
                </div>
            </div>

            <!-- Results Section -->
            <div id="resultsSection" class="hidden mt-8 space-y-6">
                <!-- Score Circle -->
                <div class="text-center">
                    <div class="relative inline-block">
                        <svg class="w-40 h-40 transform -rotate-90">
                            <circle cx="80" cy="80" r="70" stroke="rgba(255,255,255,0.1)" stroke-width="12" fill="none"/>
                            <circle id="scoreCircle" cx="80" cy="80" r="70" stroke="url(#gradient)" stroke-width="12" fill="none" stroke-dasharray="439.82" stroke-dashoffset="439.82"/>
                        </svg>
                        <defs>
                            <linearGradient id="gradient" x1="0%" y1="0%" x2="100%" y2="100%">
                                <stop offset="0%" stop-color="#8b5cf6"/>
                                <stop offset="100%" stop-color="#ec4899"/>
                            </linearGradient>
                        </defs>
                        <div class="absolute top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 text-center">
                            <span id="scoreValue" class="text-4xl font-bold text-white">0</span>
                            <span class="text-gray-300 text-lg">/100</span>
                        </div>
                    </div>
                </div>

                <!-- Strength Badge -->
                <div class="text-center">
                    <span id="strengthBadge" class="inline-block px-6 py-2 rounded-full text-white font-bold text-xl"></span>
                </div>

                <!-- Message -->
                <div class="p-4 rounded-lg bg-white/5 border border-gray-600">
                    <p id="messageText" class="text-gray-200 text-center"></p>
                </div>

                <!-- Password Checks -->
                <div class="grid grid-cols-2 gap-3">
                    <div id="uppercaseCheck" class="flex items-center space-x-2 p-3 rounded-lg bg-white/5">
                        <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                        </svg>
                        <span class="text-gray-300 text-sm">Uppercase Letter</span>
                    </div>
                    <div id="lowercaseCheck" class="flex items-center space-x-2 p-3 rounded-lg bg-white/5">
                        <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                        </svg>
                        <span class="text-gray-300 text-sm">Lowercase Letter</span>
                    </div>
                    <div id="numberCheck" class="flex items-center space-x-2 p-3 rounded-lg bg-white/5">
                        <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                        </svg>
                        <span class="text-gray-300 text-sm">Number</span>
                    </div>
                    <div id="specialCheck" class="flex items-center space-x-2 p-3 rounded-lg bg-white/5">
                        <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                        </svg>
                        <span class="text-gray-300 text-sm">Special Character</span>
                    </div>
                </div>

                <!-- Reused Password Warning -->
                <div id="reusedWarning" class="hidden p-3 rounded-lg bg-red-500/20 border border-red-500/50">
                    <div class="flex items-center space-x-2">
                        <svg class="w-5 h-5 text-red-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                        </svg>
                        <span class="text-red-300 text-sm">⚠️ This password has been used before! Please choose a new one.</span>
                    </div>
                </div>

                <!-- Suggested Password -->
                <div class="p-4 rounded-lg bg-gradient-to-r from-purple-500/20 to-pink-500/20 border border-purple-500/50">
                    <label class="block text-purple-300 text-sm font-semibold mb-2">
                        💡 Suggested Strong Password
                    </label>
                    <div class="flex items-center justify-between">
                        <code id="suggestedPassword" class="text-white font-mono text-sm break-all"></code>
                        <button id="copySuggestionBtn" class="ml-2 px-3 py-1 bg-purple-500 hover:bg-purple-600 rounded text-white text-sm transition">
                            Copy
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        const API_URL = '/api/password/analyze';
        
        let isPasswordVisible = false;

        const passwordInput = document.getElementById('passwordInput');
        const analyzeBtn = document.getElementById('analyzeBtn');
        const loadingIndicator = document.getElementById('loadingIndicator');
        const resultsSection = document.getElementById('resultsSection');
        const errorMessage = document.getElementById('errorMessage');
        const errorText = document.getElementById('errorText');
        const togglePasswordBtn = document.getElementById('togglePassword');
        const eyeIcon = document.getElementById('eyeIcon');
        const copySuggestionBtn = document.getElementById('copySuggestionBtn');

        togglePasswordBtn.addEventListener('click', () => {
            isPasswordVisible = !isPasswordVisible;
            passwordInput.type = isPasswordVisible ? 'text' : 'password';
            
            eyeIcon.innerHTML = isPasswordVisible ? 
                '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M9.88 9.88l-3.29-3.29m7.532 7.532l3.29 3.29M3 3l3.59 3.59m0 0A9.953 9.953 0 0112 5c4.478 0 8.268 2.943 9.543 7a10.025 10.025 0 01-4.132 5.411m0 0L21 21"></path>' :
                '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"></path>';
        });

        async function analyzePassword() {
            const password = passwordInput.value.trim();
            
            errorMessage.classList.add('hidden');
            
            if (!password) {
                showError('Please enter a password to analyze');
                return;
            }

            analyzeBtn.disabled = true;
            loadingIndicator.classList.remove('hidden');
            resultsSection.classList.add('hidden');

            try {
                const response = await fetch(API_URL, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify({ password: password })
                });

                if (!response.ok) {
                    throw new Error(`Server error: ${response.status}`);
                }

                const data = await response.json();
                displayResults(data);
                
            } catch (error) {
                console.error('Error:', error);
                showError('Failed to analyze password. Make sure backend is running on port 9090');
            } finally {
                analyzeBtn.disabled = false;
                loadingIndicator.classList.add('hidden');
            }
        }

        function displayResults(data) {
            const circumference = 439.82;
            const offset = circumference - (data.score / 100) * circumference;
            document.getElementById('scoreCircle').style.strokeDashoffset = offset;
            document.getElementById('scoreValue').textContent = data.score;

            const strengthBadge = document.getElementById('strengthBadge');
            strengthBadge.textContent = data.strength;
            strengthBadge.className = `inline-block px-6 py-2 rounded-full text-white font-bold text-xl strength-${data.strength}`;

            document.getElementById('messageText').textContent = data.message;

            updateCheckmark('uppercaseCheck', data.hasUppercase);
            updateCheckmark('lowercaseCheck', data.hasLowercase);
            updateCheckmark('numberCheck', data.hasNumber);
            updateCheckmark('specialCheck', data.hasSpecialCharacter);

            const reusedWarning = document.getElementById('reusedWarning');
            if (data.reusedPassword) {
                reusedWarning.classList.remove('hidden');
            } else {
                reusedWarning.classList.add('hidden');
            }

            document.getElementById('suggestedPassword').textContent = data.suggestedPassword;
            resultsSection.classList.remove('hidden');
        }

        function updateCheckmark(elementId, isValid) {
            const element = document.getElementById(elementId);
            const svg = element.querySelector('svg');
            const text = element.querySelector('span');
            
            if (isValid) {
                element.classList.add('bg-green-500/20');
                element.classList.remove('bg-white/5');
                svg.classList.add('text-green-400');
                svg.classList.remove('text-gray-400');
                text.classList.add('text-green-300');
                text.classList.remove('text-gray-300');
                svg.innerHTML = '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>';
            } else {
                element.classList.remove('bg-green-500/20');
                element.classList.add('bg-white/5');
                svg.classList.remove('text-green-400');
                svg.classList.add('text-gray-400');
                text.classList.remove('text-green-300');
                text.classList.add('text-gray-300');
                svg.innerHTML = '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>';
            }
        }

        function showError(message) {
            errorText.textContent = message;
            errorMessage.classList.remove('hidden');
            resultsSection.classList.add('hidden');
        }

        copySuggestionBtn.addEventListener('click', () => {
            const suggestedPassword = document.getElementById('suggestedPassword').textContent;
            navigator.clipboard.writeText(suggestedPassword).then(() => {
                const originalText = copySuggestionBtn.textContent;
                copySuggestionBtn.textContent = 'Copied!';
                setTimeout(() => {
                    copySuggestionBtn.textContent = originalText;
                }, 2000);
            });
        });

        passwordInput.addEventListener('keypress', (e) => {
            if (e.key === 'Enter') {
                analyzePassword();
            }
        });

        analyzeBtn.addEventListener('click', analyzePassword);
        
        console.log('Application loaded. Backend API:', API_URL);
    </script>
</body>
</html>