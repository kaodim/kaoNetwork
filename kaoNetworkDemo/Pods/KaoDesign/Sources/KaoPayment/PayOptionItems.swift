//
//  PayOptionItems.swift
//  KaoDesign
//
//  Created by Augustius on 31/05/2019.
//

import Foundation

public class PayOptionItems: TableViewVMProtocol {

    public var rowCount: Int {
        return payMethodDetails.count
    }

    private lazy var header: KaoHeaderView = {
        let view = KaoHeaderView()
        view.configure(headerTitle)
        return view
    }()

    private var headerTitle: String = ""
    private var payMethodDetails: [KaoPayMethodDetail]
    private var selectedMethod: KaoPayMethod?

    public var payMethodSelected: ((_ payMethod: KaoPayMethod) -> Void)?

    public init(_ selectedMethod: KaoPayMethod?, payMethodDetails: [KaoPayMethodDetail], headerTitle: String) {
        self.selectedMethod = selectedMethod
        self.payMethodDetails = payMethodDetails
        self.headerTitle = headerTitle
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let detail = payMethodDetails[indexPath.row]
        let selected = selectedMethod == detail.payMethod
        let onlyOneOption = rowCount == 1
        let isLastRow = indexPath.row == (rowCount - 1)

        var cell: PayOptionProtocolCell!
        switch detail.payMethod {
        case .kaodimpay:
            cell = KaodimPayOptionCell.tableView(tableView, cellForRowAt: indexPath)
        case .payAfterService, .cashOnComplete:
            cell = PayOptionCell.tableView(tableView, cellForRowAt: indexPath)
        }

        cell.configureSelected(selected)
        cell.configure(detail.title, message: detail.message)
        cell.hideCheckIcon(onlyOneOption)
        cell.hideSeperator(isLastRow)

        return cell
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = payMethodDetails[indexPath.row]
        payMethodSelected?(detail.payMethod)
    }

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return header
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
