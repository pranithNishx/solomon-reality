import Link from 'next/link';

export default function Custom500() {
  return (
    <div className="min-h-screen bg-gradient-to-b from-white to-[#f8f9fb] flex items-center justify-center px-4">
      <div className="text-center max-w-md">
        <h1 className="text-6xl font-bold mb-4">
          <span className="text-red-600">500</span>
        </h1>
        <h2 className="text-3xl font-bold mb-4 text-gray-900">
          Server Error
        </h2>
        <p className="text-gray-600 mb-8">
          Something went wrong on our end. Please try again later.
        </p>
        <Link href="/" className="inline-block px-6 py-3 bg-blue-600 text-white rounded-lg hover:bg-blue-700">
          Go Home
        </Link>
      </div>
    </div>
  );
}
