import SwiftUI

struct MenuView: View {
    @State private var toggleRotation = false
    @StateObject var router = NavigationRouter()
    @State private var showSettingsPopover = false
    @State private var selectedCategory: StomaCategory? = nil
    let categories = [nil] + StomaCategory.allCases
    @State private var showCategoryPicker: Bool = false
    @State var selectedItem: InfoItem?
    
    let items: [InfoItem] = InfoItem.sampleItems
    
    
    var body: some View {
        NavigationStack(path: $router.path) {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                
                    Text("Practice with Simulators")
                        .font(.title2)
                        .bold()
                        .padding(.leading)
                    
                    MenuCaroussel(data: CardData.sampleData)
                    
                    
                    HStack{
                        Text("Learn the Tools")
                            .font(.title2)
                            .bold()
                            .padding(.leading)
                        
                        Spacer()
                        
                        Button {
                            showCategoryPicker.toggle()
                        } label: {
                            Image(systemName: "slider.horizontal.3")
                                .imageScale(.large)
                        }
                        .padding(.trailing)
                        .popover(isPresented: $showCategoryPicker) {
                            VStack(alignment: .leading) {
                                Text("Choose category")
                                    .font(.headline)
                                
                                Picker("Category", selection: $selectedCategory) {
                                    Text("All").tag(StomaCategory?.none)
                                    ForEach(StomaCategory.allCases) { category in
                                        Text(category.rawValue.capitalized).tag(Optional(category))
                                    }
                                }
                                .pickerStyle(.inline)
                            }
                            .padding()
                            .frame(width: 250)
                        }
                    }
                        
                    ToolCaroussel(
                        items: items.filter { selectedCategory == nil || $0.categories.contains(selectedCategory!) },
                        selectedItem: .constant(nil)
                    )
                    
                    Text("Connect with Stories")
                        .font(.title2)
                        .bold()
                        .padding(.leading)
                    
                    MenuCaroussel(data: CardData.storyData)
                }
                //.padding(.leading)

                //.background(Color.white.ignoresSafeArea())
            }
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                    toggleRotation.toggle()
                }
            }
            .navigationDestination(for: Route.self) { route in
                router.destination(for: route)
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showSettingsPopover.toggle()
                    } label: {
                        Image(systemName: "gearshape.fill")
                    }
                    .popover(isPresented: $showSettingsPopover) {
                        AppSettingsView()
                    }
                }
            }
            .navigationTitle("Explore & Learn")
        }
        .environmentObject(router)
        //.background(Color.white.ignoresSafeArea())

    }
}


#Preview {
    MenuView()
        .environmentObject(NavigationRouter())
        .environmentObject(OstomyViewModel(ostomy: loadOstomyFromBundle() ?? defaultOstomy))
}
