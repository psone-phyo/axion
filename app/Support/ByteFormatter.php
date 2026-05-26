<?php

namespace App\Support;

class ByteFormatter
{
    public static function humanReadable(?int $bytes): string
    {
        if ($bytes === null) {
            return '-';
        }

        if ($bytes < 1024) {
            return $bytes . ' B';
        }

        $units = ['KB', 'MB', 'GB', 'TB'];
        $value = $bytes;
        $unitIndex = -1;

        while ($value >= 1024 && $unitIndex < count($units) - 1) {
            $value /= 1024;
            $unitIndex++;
        }

        $precision = $value >= 10 ? 0 : 1;

        return number_format($value, $precision) . ' ' . $units[$unitIndex];
    }

    public static function gigabytesToBytes(int|float $gigabytes): int
    {
        return (int) round($gigabytes * 1024 * 1024 * 1024);
    }
}
