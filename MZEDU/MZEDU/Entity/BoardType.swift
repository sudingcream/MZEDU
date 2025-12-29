enum BoardType {
    case free
    case secret

    var title: String {
        switch self {
        case .free: return "자유게시판"
        case .secret: return "비밀게시판"
        }
    }
}
