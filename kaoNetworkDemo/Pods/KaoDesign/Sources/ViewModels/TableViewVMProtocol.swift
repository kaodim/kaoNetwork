//
//  TableViewVMProtocol.swift
//  KaoDesign
//
//  Created by augustius cokroe on 14/03/2019.
//

import Foundation

public protocol TableViewVMProtocol {
    var rowCount: Int { get }
    var sectionTitle: String { get }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
}

public extension TableViewVMProtocol {
    var rowCount: Int { return 1 }
    var sectionTitle: String { return "" }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? { return nil }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { return 0 }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? { return nil }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat { return 0 }
}
