//
//  KaoPaySummaryItems.swift
//  KaoDesign
//
//  Created by Augustius on 03/06/2019.
//

import Foundation

public class KaoPaySummaryItems: TableViewVMProtocol {

    private var titleText: String = ""
    private var amountText: String = ""

    public init(_ titleText: String, amountText: String) {
        self.titleText = titleText
        self.amountText = amountText
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: KaoPayHeaderCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.configure(titleText, amount: amountText)
        return cell
    }
}
