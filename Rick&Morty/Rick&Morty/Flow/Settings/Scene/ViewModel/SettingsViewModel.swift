//
//  SettingsViewModel.swift
//  Rick&Morty
//
//  Created by Alexander V. on 08.11.2023.
//

final class SettingsViewModel {
    
    // MARK: - Private property
    private var itemsSettingViewModel: [ItemSettingViewModel] = [
        ItemSettingViewModel(title: "Сменить пароль",
                             icon: R.Images.settingChangePass,
                             isNavigate: true,
                             navigation: .changePassword),
        ItemSettingViewModel(title: "Выход",
                             icon: R.Images.settingExit,
                             isNavigate: true,
                             navigation: .logout)
    ]
    private var auth: LogoutAuth?
    
    // MARK: - Public property
    var settingCount: Int {
        itemsSettingViewModel.count
    }
    
    // MARK: - Init
    init(auth: LogoutAuth?) {
        self.auth = auth
    }
    
    // MARK: - Public methods
    func getItemSettingsViewModel(row: Int) -> ItemSettingViewModel {
        itemsSettingViewModel[row]
    }
    
    func cellSelected(row: Int) -> SettingsViewNavigation {
        let router = itemsSettingViewModel[row].navigation
        if router == .logout { logout() }
        return router
    }
    
    // MARK: - Private methods
    private func logout() {
        auth?.logOut()
    }
}
