//
//  GroupSettingsViewController.swift
//  DutieSplit
//


import UIKit

internal final class GroupSettingsViewController: MVVMViewController<GroupSettingsView, GroupSettingsViewModel>, BindingsSetupable, NavigationBarSetupable, UITableViewDataSource, UITableViewDelegate {

    private let editNameButton = UIBarButtonItem(title: Localizable.GroupSettingsScreen.editName, style: .plain, target: nil, action: nil)
    
    /// - SeeAlso: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = editNameButton
        customView.tableView.dataSource = self
        customView.tableView.delegate = self
    }
    
    /// - SeeAlso: NavigationBarSetupable
    func setup(navigationBar: UINavigationBar) {
        navigationBar.tintColor = .dsRed
        if #available(iOS 11.0, *) {
            navigationBar.prefersLargeTitles = false
        }
    }
    
    /// - SeeAlso: BindingsSetupable
    func setupBindings() {
        viewModel.groupName.asDriver().drive(rx.title).disposed(by: disposeBag)
        editNameButton.rx.tap.bind(to: viewModel.editNameTapped).disposed(by: disposeBag)

        viewModel.showEditNameAlert = { [unowned self] prefilledText in
            self.showTextFieldAlert(
                withMessage: Localizable.GroupSettingsScreen.editName,
                title: nil,
                prefilledText: prefilledText,
                placeholder: Localizable.GroupSettingsScreen.groupName,
                onConfirmTap: { groupName in
                    self.viewModel.changeGroupName(to: groupName)
                }
            )
        }
    }

    /// - SeeAlso: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    /// - SeeAlso: UITableViewDataSource
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view: UIView?
        switch section {
        case 0:
            view = SectionHeader(
                leftLabelTitle: Localizable.GroupSettingsScreen.groupMembers,
                height: .large,
                rightButtonTitle: Localizable.GroupSettingsScreen.addMember,
                onRightButtonTap: { [unowned self] in
                    self.showTextFieldAlert(
                        withMessage: Localizable.GroupSettingsScreen.addMemberAlertMessage,
                        title: nil,
                        prefilledText: nil,
                        placeholder: Localizable.GroupSettingsScreen.emailPlaceholder,
                        onConfirmTap: { personEmail in
                            self.viewModel.addToGroup(email: personEmail)
                        }
                    )
                }
            )
        default:
            view = nil
        }
        return view
    }

    /// - SeeAlso: UITableViewDataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: GroupMemberTableViewCell = tableView.dequeueReusableCell(for: indexPath) else { return UITableViewCell() }
        return cell
    }
}

