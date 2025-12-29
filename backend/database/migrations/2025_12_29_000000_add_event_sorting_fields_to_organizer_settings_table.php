<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::table('organizer_settings', static function (Blueprint $table) {
            $table->string('homepage_event_sort_by', 50)->nullable()->default('start_date');
            $table->string('homepage_event_sort_direction', 10)->nullable()->default('asc');
        });
    }

    public function down(): void
    {
        Schema::table('organizer_settings', static function (Blueprint $table) {
            $table->dropColumn(['homepage_event_sort_by', 'homepage_event_sort_direction']);
        });
    }
};
