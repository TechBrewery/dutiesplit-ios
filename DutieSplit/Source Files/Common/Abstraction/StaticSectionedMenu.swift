//
//  StaticSectionedMenu.swift
//  DutieSplit
//


/// Defines static menu of sections
internal struct StaticSectionedMenu<T> {
    
    let sections: [StaticSection<T>]

    subscript(indexPath: IndexPath) -> T {
        return sections[indexPath.section].cells[indexPath.row]
    }
}
