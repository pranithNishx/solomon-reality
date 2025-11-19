'use client';

export default function GlobalError({
  error,
  reset,
}: {
  error: Error & { digest?: string };
  reset: () => void;
}) {
  return (
    <>
      <div className="min-h-screen bg-gradient-to-b from-white to-[#f8f9fb] flex items-center justify-center px-4">
        <div className="text-center max-w-md">
          <h1 className="text-6xl font-display font-bold mb-4">
            <span className="text-red-500">Error</span>
          </h1>
          <h2 className="text-3xl font-display font-bold mb-4 text-gray-900">
            Something went wrong
          </h2>
          <p className="text-gray-600 mb-8">
            {error.message || 'An unexpected error occurred'}
          </p>
          <button onClick={reset} className="px-6 py-3 bg-blue-600 text-white rounded-lg hover:bg-blue-700">
            Try Again
          </button>
        </div>
      </div>
    </>
  );
}
