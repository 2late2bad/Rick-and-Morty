//
//  SettingsViewModel.swift
//  Rick&Morty
//
//  Created by Alexander V. on 08.11.2023.
//

final class SettingsViewModel {
    
    private var itemsSettingViewModel: [ItemSettingViewModel] = [
        ItemSettingViewModel(title: "Сменить пароль", icon: "archivebox.circle", isNavigate: true, navigation: .changePassword),
        ItemSettingViewModel(title: "Выход", icon: "door.right.hand.open", isNavigate: true, navigation: .logout)
    ]
    private var auth: LogoutAuth?
    
    var settingCount: Int {
        itemsSettingViewModel.count
    }
    
    init(auth: LogoutAuth?) {
        self.auth = auth
    }
    
    private func logout() {
        auth?.logOut()
    }
    
    func getItemSettingsViewModel(row: Int) -> ItemSettingViewModel {
        itemsSettingViewModel[row]
    }
    
    func cellSelected(row: Int) -> SettingsViewNavigation {
        let router = itemsSettingViewModel[row].navigation
        if router == .logout { logout() }
        return router
    }
}
