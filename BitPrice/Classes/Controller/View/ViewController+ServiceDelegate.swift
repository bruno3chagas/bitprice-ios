//
//  ViewController+ServiceDelegate.swift
//  BitPrice
//
//  Created by Bruno Tortato Furtado on 02/02/18.
//  Copyright © 2018 Bruno Tortato Furtado. All rights reserved.
//

import UI
import UIKit

extension ViewController: TickerServiceDelegate {

    func tickerGetDidComplete(ticker: Ticker, date: Date, fromCache: Bool) {
        bodyView.priceView.setPrice(ticker.USD.last, date: date)
        bodyView.priceView.spinnerView.hide()

        if fromCache {
            StatusBarNotificationBannerComponent.noConnection.show()
        }
    }

    func tickerGetDidComplete(failure: ServiceFailureType) {
        bodyView.priceView.setPrice(0)
        bodyView.priceView.spinnerView.hide()

        switch failure {
        case .server:
            StatusBarNotificationBannerComponent.serverFailure.show()
        case .connection:
            StatusBarNotificationBannerComponent.noConnection.show()
        }
    }

}

extension ViewController: MarketPriceServiceDelegate {

    func marketPriceGetDidComplete(marketPrice: MarketPrice) {
        let ref = UserDefaults.standard.reference()

        let firsPrice = marketPrice.values.first?.yAxis ?? 0
        let lastPrice = marketPrice.values.last?.yAxis ?? 0
        var values = [ChartDataEntry]()

        for value in marketPrice.values {
            let xAxis = Double(value.xAxis)
            let yAxis = Double(value.yAxis)
            values.append(ChartDataEntry(xAxis: xAxis, yAxis: yAxis))
        }

        bodyView.historyView.setLoaded(true)
        bodyView.historyView.setPrices(firstPrice: firsPrice, lastPrice: lastPrice)
        bodyView.historyView.setChartData(reference: ref, values: values)
        bodyView.historyView.spinnerView.hide()
    }

    func marketPriceGetDidComplete(failure: ServiceFailureType) {
        bodyView.historyView.setLoaded(true)
        bodyView.historyView.spinnerView.hide()
    }

}
