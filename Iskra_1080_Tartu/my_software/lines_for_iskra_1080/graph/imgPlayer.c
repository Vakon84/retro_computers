#include "imgPlayer.h"

uint8_t imgPlayer[500] = {
    0x10, 0x38, 0x38, 0x38, 0x38, 0x38, 0x38, 0x38, 0x38, 0x38, 0x38, 0x38, 0x38, 0x38, 0x38, 0x38, 0x38, 0x82, 0xFE,
    0xDA, 0x8A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x38, 0x7C, 0x38, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x40, 0xE0, 0x70,
    0x79, 0x3B, 0x37, 0x17, 0x1B, 0x0B, 0x01, 0x10, 0x08, 0x14, 0x0A, 0x15, 0x0A, 0x15, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0xE0, 0xFC, 0xDF, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x1D, 0x10, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0xC0, 0xDF, 0x9F, 0x80, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x41, 0x82, 0x01, 0x00, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0xE0, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xC0, 0x40, 0x40, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x07, 0xFF, 0xFF, 0xFF, 0xFF, 0x0F, 0x01, 0x00, 0x00, 0x01, 0x02, 0x15, 0x0A,
    0x14, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x10, 0x38, 0xF8, 0xFC, 0xFC,
    0xFC, 0xFE, 0xFE, 0xFE, 0xFE, 0xFE, 0x7E, 0x3E, 0x0F, 0xA7, 0x53, 0xAB, 0x13, 0x0B, 0x03, 0x09, 0x04, 0x00, 0x00,
    0x38, 0xF8, 0xD8, 0x10, 0x38, 0x38, 0x38, 0x38, 0x38, 0x38, 0x38, 0x38, 0x38, 0x38, 0x38, 0x38, 0x38, 0x38, 0x38,
    0x38, 0x82, 0xFE, 0xDA, 0x8A, 0x60, 0x60, 0x40, 0x7C, 0x7D, 0x7D, 0x7D, 0x01, 0x38, 0x7C, 0x38, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x03, 0x07, 0x0F, 0x0F, 0x1F, 0x1F, 0x3F, 0x1F,
    0x0F, 0x06, 0x80, 0x81, 0xC3, 0x87, 0x07, 0x03, 0x03, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1C,
    0x32, 0x3B, 0x3F, 0x3F, 0x1F, 0xE0, 0xFC, 0xDF, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x03, 0x04, 0x07, 0x09, 0x08,
    0x07, 0x1F, 0x62, 0xDD, 0xD2, 0xD2, 0xE2, 0xF7, 0xEF, 0xDF, 0xDF, 0xDF, 0xE0, 0xBF, 0x40, 0x3F, 0x9E, 0xC0, 0xC0,
    0x80, 0x80, 0x3F, 0x7F, 0xFF, 0xFF, 0x7F, 0x1F, 0x18, 0x18, 0x18, 0x38, 0x78, 0xF8, 0xFC, 0xFC, 0xF8, 0x00, 0x00,
    0xE0, 0x80, 0xC0, 0x80, 0xC0, 0x40, 0xC0, 0x80, 0x00, 0x80, 0x80, 0x00, 0x00, 0xC0, 0x30, 0xDC, 0x5E, 0x5F, 0x3F,
    0x7F, 0xBF, 0xDF, 0xDF, 0xDF, 0x3F, 0xEE, 0x1C, 0xF0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xF0, 0xFE, 0xFC, 0xF8,
    0xC0, 0x40, 0x40, 0x40, 0x41, 0x63, 0x7F, 0xFF, 0xFF, 0x7F, 0x00, 0x01, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0xC0, 0xE0, 0xE0, 0xE0, 0xC0, 0x80, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xC0, 0x20, 0xA0,
    0xE0, 0xE0, 0xC0, 0x38, 0xF8, 0xD8,
};
