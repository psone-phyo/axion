<?php

use Filament\Notifications\Notification;
use Illuminate\Foundation\Application;
use Illuminate\Foundation\Configuration\Exceptions;
use Illuminate\Foundation\Configuration\Middleware;
use Illuminate\Database\Eloquent\ModelNotFoundException;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Symfony\Component\HttpKernel\Exception\HttpExceptionInterface;

return Application::configure(basePath: dirname(__DIR__))
    ->withRouting(
        web: __DIR__.'/../routes/web.php',
        commands: __DIR__.'/../routes/console.php',
        health: '/up',
    )
    ->withMiddleware(function (Middleware $middleware): void {
        //
    })
    ->withExceptions(function (Exceptions $exceptions): void {
        $exceptions->render(function (ModelNotFoundException $exception, Request $request) {
            if (app()->isLocal() || $request->expectsJson() || ! $request->is('admin*')) {
                return null;
            }

            $message = 'The requested record could not be found.';

            Log::warning('Admin request failed with missing model.', [
                'path' => $request->path(),
                'message' => $exception->getMessage(),
            ]);

            Notification::make()
                ->danger()
                ->title('Action failed')
                ->body($message)
                ->send();

            return redirect()->back()->withInput()->with('danger', $message);
        });

        $exceptions->render(function (Throwable $exception, Request $request) {
            if (
                app()->isLocal() ||
                $request->expectsJson() ||
                ! $request->is('admin*') ||
                $exception instanceof HttpExceptionInterface
            ) {
                return null;
            }

            $message = $exception->getMessage() ?: 'Something went wrong. Please try again.';

            Log::error('Admin request failed.', [
                'path' => $request->path(),
                'message' => $exception->getMessage(),
                'exception' => $exception::class,
            ]);

            Notification::make()
                ->danger()
                ->title('Action failed')
                ->body($message)
                ->send();

            return redirect()->back()->withInput()->with('danger', $message);
        });
    })->create();
