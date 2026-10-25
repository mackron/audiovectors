#!/bin/sh

set -e

mkdir -p vectors/wav/generated/ffmpeg vectors/flac/generated/ffmpeg

# Four frames per file. Integer samples: minimum, midpoint - 1, midpoint, maximum.
# Float samples: -1.0, -0.5, 0.0, 1.0. Stereo uses the reverse sequence on the right.

printf '\000\177\200\377' | \
    ffmpeg -hide_banner -loglevel error -f u8 -ar 8000 -ac 1 -i pipe:0 -map_metadata -1 -c:a pcm_u8 -fflags +bitexact -flags:a +bitexact -y vectors/wav/generated/ffmpeg/u8_mono.wav

printf '\000\200\377\377\000\000\377\177' | \
    ffmpeg -hide_banner -loglevel error -f s16le -ar 8000 -ac 1 -i pipe:0 -map_metadata -1 -c:a pcm_s16le -fflags +bitexact -flags:a +bitexact -y vectors/wav/generated/ffmpeg/s16_mono.wav

printf '\000\000\200\377\377\377\000\000\000\377\377\177' | \
    ffmpeg -hide_banner -loglevel error -f s24le -ar 8000 -ac 1 -i pipe:0 -map_metadata -1 -c:a pcm_s24le -fflags +bitexact -flags:a +bitexact -y vectors/wav/generated/ffmpeg/s24_mono.wav

printf '\000\000\000\200\377\377\377\377\000\000\000\000\377\377\377\177' | \
    ffmpeg -hide_banner -loglevel error -f s32le -ar 8000 -ac 1 -i pipe:0 -map_metadata -1 -c:a pcm_s32le -fflags +bitexact -flags:a +bitexact -y vectors/wav/generated/ffmpeg/s32_mono.wav

printf '\000\000\200\277\000\000\000\277\000\000\000\000\000\000\200\077' | \
    ffmpeg -hide_banner -loglevel error -f f32le -ar 8000 -ac 1 -i pipe:0 -map_metadata -1 -c:a pcm_f32le -fflags +bitexact -flags:a +bitexact -y vectors/wav/generated/ffmpeg/f32_mono.wav

printf '\000\377\177\200\200\177\377\000' | \
    ffmpeg -hide_banner -loglevel error -f u8 -ar 8000 -ac 2 -i pipe:0 -map_metadata -1 -c:a pcm_u8 -fflags +bitexact -flags:a +bitexact -y vectors/wav/generated/ffmpeg/u8_stereo.wav

printf '\000\200\377\177\377\377\000\000\000\000\377\377\377\177\000\200' | \
    ffmpeg -hide_banner -loglevel error -f s16le -ar 8000 -ac 2 -i pipe:0 -map_metadata -1 -c:a pcm_s16le -fflags +bitexact -flags:a +bitexact -y vectors/wav/generated/ffmpeg/s16_stereo.wav

printf '\000\000\200\377\377\177\377\377\377\000\000\000\000\000\000\377\377\377\377\377\177\000\000\200' | \
    ffmpeg -hide_banner -loglevel error -f s24le -ar 8000 -ac 2 -i pipe:0 -map_metadata -1 -c:a pcm_s24le -fflags +bitexact -flags:a +bitexact -y vectors/wav/generated/ffmpeg/s24_stereo.wav

printf '\000\000\000\200\377\377\377\177\377\377\377\377\000\000\000\000\000\000\000\000\377\377\377\377\377\377\377\177\000\000\000\200' | \
    ffmpeg -hide_banner -loglevel error -f s32le -ar 8000 -ac 2 -i pipe:0 -map_metadata -1 -c:a pcm_s32le -fflags +bitexact -flags:a +bitexact -y vectors/wav/generated/ffmpeg/s32_stereo.wav

printf '\000\000\200\277\000\000\200\077\000\000\000\277\000\000\000\000\000\000\000\000\000\000\000\277\000\000\200\077\000\000\200\277' | \
    ffmpeg -hide_banner -loglevel error -f f32le -ar 8000 -ac 2 -i pipe:0 -map_metadata -1 -c:a pcm_f32le -fflags +bitexact -flags:a +bitexact -y vectors/wav/generated/ffmpeg/f32_stereo.wav



# FLAC: four frames, with the right channel in reverse sample order.
# FFmpeg requires experimental mode for 32-bit FLAC to avoid reducing it to 24 bits.

printf '\000\200\377\377\000\000\377\177' | \
    ffmpeg -hide_banner -loglevel error -f s16le -ar 8000 -ac 1 -i pipe:0 -map_metadata -1 -c:a flac -sample_fmt s16 -bits_per_raw_sample 16 -frame_size 1152 -fflags +bitexact -flags:a +bitexact -y vectors/flac/generated/ffmpeg/s16_mono.flac

printf '\000\000\200\377\377\377\000\000\000\377\377\177' | \
    ffmpeg -hide_banner -loglevel error -f s24le -ar 8000 -ac 1 -i pipe:0 -map_metadata -1 -c:a flac -sample_fmt s32 -bits_per_raw_sample 24 -frame_size 1152 -fflags +bitexact -flags:a +bitexact -y vectors/flac/generated/ffmpeg/s24_mono.flac

printf '\000\000\000\200\377\377\377\377\000\000\000\000\377\377\377\177' | \
    ffmpeg -hide_banner -loglevel error -f s32le -ar 8000 -ac 1 -i pipe:0 -map_metadata -1 -c:a flac -sample_fmt s32 -bits_per_raw_sample 32 -strict experimental -frame_size 1152 -fflags +bitexact -flags:a +bitexact -y vectors/flac/generated/ffmpeg/s32_mono.flac

printf '\000\200\377\177\377\377\000\000\000\000\377\377\377\177\000\200' | \
    ffmpeg -hide_banner -loglevel error -f s16le -ar 8000 -ac 2 -i pipe:0 -map_metadata -1 -c:a flac -sample_fmt s16 -bits_per_raw_sample 16 -frame_size 1152 -fflags +bitexact -flags:a +bitexact -y vectors/flac/generated/ffmpeg/s16_stereo.flac

printf '\000\000\200\377\377\177\377\377\377\000\000\000\000\000\000\377\377\377\377\377\177\000\000\200' | \
    ffmpeg -hide_banner -loglevel error -f s24le -ar 8000 -ac 2 -i pipe:0 -map_metadata -1 -c:a flac -sample_fmt s32 -bits_per_raw_sample 24 -frame_size 1152 -fflags +bitexact -flags:a +bitexact -y vectors/flac/generated/ffmpeg/s24_stereo.flac

printf '\000\000\000\200\377\377\377\177\377\377\377\377\000\000\000\000\000\000\000\000\377\377\377\377\377\377\377\177\000\000\000\200' | \
    ffmpeg -hide_banner -loglevel error -f s32le -ar 8000 -ac 2 -i pipe:0 -map_metadata -1 -c:a flac -sample_fmt s32 -bits_per_raw_sample 32 -strict experimental -frame_size 1152 -fflags +bitexact -flags:a +bitexact -y vectors/flac/generated/ffmpeg/s32_stereo.flac
