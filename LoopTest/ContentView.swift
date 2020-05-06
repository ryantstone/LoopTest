import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    
    struct State: Equatable, Hashable {
        var menuIsOpen = false
        var hellos: [HellosView.State] = []
    }
    
    enum Actions {
        case
        didTapMenuButton(index: Int, word: HellosView.Actions),
        add
    }
    
    let store: Store<State, Actions>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack {
                HStack {
                    ForEachStore(
                        self.store.scope(
                            state: \.hellos,
                            action: Actions.didTapMenuButton(index:word:)
                        ),
                        id: \.self,
                        content: HellosView.init(store:)
                    )
                }
                Button(action: { viewStore.send(.add) }) {
                    Text("Add")
                }
            }
            
        }
    }
}


let contentViewReducer = Reducer<ContentView.State, ContentView.Actions, Void>.combine(
    .init { state, actions, _ in
    switch actions {
    case .didTapMenuButton(index: let index, word: let helloState):
        state.hellos.remove(at: index)
    case .add:
        state.hellos.append(.init(message: "Hello"))
        }
        
        return .none
    }, helloViewReducer.forEach(
        state: \ContentView.State.hellos,
        action: /ContentView.Actions.didTapMenuButton(index:word:),
        environment: { $0 }
    )
)

let helloViewReducer = Reducer<HellosView.State, HellosView.Actions, Void> .init { state, actions, _ in
    switch actions {
    case .didTapText:
        break
    }
    
    return .none
}
