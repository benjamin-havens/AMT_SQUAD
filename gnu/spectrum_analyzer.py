#!/usr/bin/env python3
# -*- coding: utf-8 -*-

#
# SPDX-License-Identifier: GPL-3.0
#
# GNU Radio Python Flow Graph
# Title: spectrum_analyzer
# GNU Radio version: 3.8.1.0

from distutils.version import StrictVersion

if __name__ == '__main__':
    import ctypes
    import sys
    if sys.platform.startswith('linux'):
        try:
            x11 = ctypes.cdll.LoadLibrary('libX11.so')
            x11.XInitThreads()
        except:
            print("Warning: failed to XInitThreads()")

from PyQt5 import Qt
from gnuradio import qtgui
from gnuradio.filter import firdes
import sip
from gnuradio import gr
import sys
import signal
from argparse import ArgumentParser
from gnuradio.eng_arg import eng_float, intx
from gnuradio import eng_notation
from gnuradio import uhd
import time
from gnuradio.qtgui import Range, RangeWidget
from gnuradio import qtgui

class spectrum_analyzer(gr.top_block, Qt.QWidget):

    def __init__(self):
        gr.top_block.__init__(self, "spectrum_analyzer")
        Qt.QWidget.__init__(self)
        self.setWindowTitle("spectrum_analyzer")
        qtgui.util.check_set_qss()
        try:
            self.setWindowIcon(Qt.QIcon.fromTheme('gnuradio-grc'))
        except:
            pass
        self.top_scroll_layout = Qt.QVBoxLayout()
        self.setLayout(self.top_scroll_layout)
        self.top_scroll = Qt.QScrollArea()
        self.top_scroll.setFrameStyle(Qt.QFrame.NoFrame)
        self.top_scroll_layout.addWidget(self.top_scroll)
        self.top_scroll.setWidgetResizable(True)
        self.top_widget = Qt.QWidget()
        self.top_scroll.setWidget(self.top_widget)
        self.top_layout = Qt.QVBoxLayout(self.top_widget)
        self.top_grid_layout = Qt.QGridLayout()
        self.top_layout.addLayout(self.top_grid_layout)

        self.settings = Qt.QSettings("GNU Radio", "spectrum_analyzer")

        try:
            if StrictVersion(Qt.qVersion()) < StrictVersion("5.0.0"):
                self.restoreGeometry(self.settings.value("geometry").toByteArray())
            else:
                self.restoreGeometry(self.settings.value("geometry"))
        except:
            pass

        ##################################################
        # Variables
        ##################################################
        self.tuning = tuning = 1485e6
        self.samp_rate = samp_rate = 20e6
        self.rf1_gain = rf1_gain = 50
        self.rf0_gain = rf0_gain = 60

        ##################################################
        # Blocks
        ##################################################
        self._tuning_range = Range(1000e6, 2000e6, 100e6, 1485e6, 200)
        self._tuning_win = RangeWidget(self._tuning_range, self.set_tuning, 'Frequency', "counter_slider", float)
        self.top_grid_layout.addWidget(self._tuning_win)
        self._samp_rate_range = Range(192e3, 56e6, 1000, 20e6, 200)
        self._samp_rate_win = RangeWidget(self._samp_rate_range, self.set_samp_rate, 'Sample Rate', "counter_slider", float)
        self.top_grid_layout.addWidget(self._samp_rate_win)
        self._rf1_gain_range = Range(0, 76, 1, 50, 200)
        self._rf1_gain_win = RangeWidget(self._rf1_gain_range, self.set_rf1_gain, 'RF_gain', "counter_slider", float)
        self.top_grid_layout.addWidget(self._rf1_gain_win)
        self._rf0_gain_range = Range(0, 76, 1, 60, 200)
        self._rf0_gain_win = RangeWidget(self._rf0_gain_range, self.set_rf0_gain, 'RF_gain', "counter_slider", float)
        self.top_grid_layout.addWidget(self._rf0_gain_win)
        self.uhd_usrp_source_0 = uhd.usrp_source(
            ",".join(("", "")),
            uhd.stream_args(
                cpu_format="fc32",
                args='',
                channels=list(range(0,2)),
            ),
        )
        self.uhd_usrp_source_0.set_center_freq(tuning, 0)
        self.uhd_usrp_source_0.set_rx_agc(False, 0)
        self.uhd_usrp_source_0.set_gain(rf0_gain, 0)
        self.uhd_usrp_source_0.set_antenna('TX/RX', 0)
        self.uhd_usrp_source_0.set_bandwidth(10e6, 0)
        self.uhd_usrp_source_0.set_center_freq(tuning, 1)
        self.uhd_usrp_source_0.set_rx_agc(False, 1)
        self.uhd_usrp_source_0.set_gain(rf1_gain, 1)
        self.uhd_usrp_source_0.set_antenna('RX2', 1)
        self.uhd_usrp_source_0.set_bandwidth(10e6, 1)
        self.uhd_usrp_source_0.set_samp_rate(samp_rate)
        # No synchronization enforced.
        self.qtgui_sink_x_0_0 = qtgui.sink_c(
            1024, #fftsize
            firdes.WIN_BLACKMAN_hARRIS, #wintype
            tuning, #fc
            20e6, #bw
            'Spectrum Analyzer B', #name
            True, #plotfreq
            True, #plotwaterfall
            True, #plottime
            True #plotconst
        )
        self.qtgui_sink_x_0_0.set_update_time(1.0/10)
        self._qtgui_sink_x_0_0_win = sip.wrapinstance(self.qtgui_sink_x_0_0.pyqwidget(), Qt.QWidget)

        self.qtgui_sink_x_0_0.enable_rf_freq(False)

        self.top_grid_layout.addWidget(self._qtgui_sink_x_0_0_win)
        self.qtgui_sink_x_0 = qtgui.sink_c(
            1024, #fftsize
            firdes.WIN_BLACKMAN_hARRIS, #wintype
            tuning, #fc
            20e6, #bw
            'Spectrum Analyzer A', #name
            True, #plotfreq
            True, #plotwaterfall
            True, #plottime
            True #plotconst
        )
        self.qtgui_sink_x_0.set_update_time(1.0/10)
        self._qtgui_sink_x_0_win = sip.wrapinstance(self.qtgui_sink_x_0.pyqwidget(), Qt.QWidget)

        self.qtgui_sink_x_0.enable_rf_freq(False)

        self.top_grid_layout.addWidget(self._qtgui_sink_x_0_win)



        ##################################################
        # Connections
        ##################################################
        self.connect((self.uhd_usrp_source_0, 0), (self.qtgui_sink_x_0, 0))
        self.connect((self.uhd_usrp_source_0, 1), (self.qtgui_sink_x_0_0, 0))

    def closeEvent(self, event):
        self.settings = Qt.QSettings("GNU Radio", "spectrum_analyzer")
        self.settings.setValue("geometry", self.saveGeometry())
        event.accept()

    def get_tuning(self):
        return self.tuning

    def set_tuning(self, tuning):
        self.tuning = tuning
        self.qtgui_sink_x_0.set_frequency_range(self.tuning, 20e6)
        self.qtgui_sink_x_0_0.set_frequency_range(self.tuning, 20e6)
        self.uhd_usrp_source_0.set_center_freq(self.tuning, 0)
        self.uhd_usrp_source_0.set_center_freq(self.tuning, 1)

    def get_samp_rate(self):
        return self.samp_rate

    def set_samp_rate(self, samp_rate):
        self.samp_rate = samp_rate
        self.uhd_usrp_source_0.set_samp_rate(self.samp_rate)

    def get_rf1_gain(self):
        return self.rf1_gain

    def set_rf1_gain(self, rf1_gain):
        self.rf1_gain = rf1_gain
        self.uhd_usrp_source_0.set_gain(self.rf1_gain, 1)

    def get_rf0_gain(self):
        return self.rf0_gain

    def set_rf0_gain(self, rf0_gain):
        self.rf0_gain = rf0_gain
        self.uhd_usrp_source_0.set_gain(self.rf0_gain, 0)



def main(top_block_cls=spectrum_analyzer, options=None):

    if StrictVersion("4.5.0") <= StrictVersion(Qt.qVersion()) < StrictVersion("5.0.0"):
        style = gr.prefs().get_string('qtgui', 'style', 'raster')
        Qt.QApplication.setGraphicsSystem(style)
    qapp = Qt.QApplication(sys.argv)

    tb = top_block_cls()
    tb.start()
    tb.show()

    def sig_handler(sig=None, frame=None):
        Qt.QApplication.quit()

    signal.signal(signal.SIGINT, sig_handler)
    signal.signal(signal.SIGTERM, sig_handler)

    timer = Qt.QTimer()
    timer.start(500)
    timer.timeout.connect(lambda: None)

    def quitting():
        tb.stop()
        tb.wait()
    qapp.aboutToQuit.connect(quitting)
    qapp.exec_()


if __name__ == '__main__':
    main()
