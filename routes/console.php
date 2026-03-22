<?php

use App\Support\PushAutomationService;
use Illuminate\Foundation\Inspiring;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\Schedule;

Artisan::command('inspire', function () {
    $this->comment(Inspiring::quote());
})->purpose('Display an inspiring quote');

Artisan::command('push:auto-plan', function () {
    /** @var PushAutomationService $service */
    $service = app(PushAutomationService::class);

    $result = $service->plan();

    $this->info(json_encode($result, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES));
})->purpose('Planifica notificaciones push para cortes de prestamos');

Artisan::command('push:auto-dispatch', function () {
    /** @var PushAutomationService $service */
    $service = app(PushAutomationService::class);

    $result = $service->dispatch();

    $this->info(json_encode($result, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES));
})->purpose('Despacha notificaciones push pendientes');

Artisan::command('push:auto-cycle', function () {
    /** @var PushAutomationService $service */
    $service = app(PushAutomationService::class);

    $plan = $service->plan();
    $dispatch = $service->dispatch();

    $this->info(json_encode([
        'plan' => $plan,
        'dispatch' => $dispatch,
    ], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES));
})->purpose('Planifica y despacha en un solo comando');

Schedule::call(function (): void {
    /** @var PushAutomationService $service */
    $service = app(PushAutomationService::class);
    $service->plan();
})
    ->hourlyAt(0)
    ->name('push:auto-plan-hourly')
    ->withoutOverlapping();

Schedule::call(function (): void {
    /** @var PushAutomationService $service */
    $service = app(PushAutomationService::class);
    $service->dispatch();
})
    ->everyMinute()
    ->name('push:auto-dispatch-minute')
    ->withoutOverlapping();
