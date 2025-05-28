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
                    
                    MenuCaroussel(data: CardData.sampleData)
                    
                    
                    HStack{
                        Text("Learn the Tools")
                            .font(.title2)
                            .bold()
                        
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
                    
                    MenuCaroussel(data: CardData.storyData)
                }
                .padding(.leading)

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
/*
            ZStack(alignment: .top) {
                ScrollView {
                    VStack(alignment: .leading) {
                        HStack {
                            NavigationLink {
                                ToolsView()
                            } label: {
                                Image (systemName: "cross.case.fill")
                                    .padding()
                                    .font(.system(size: 40))
                                    .foregroundColor(Color.bluePrimary)
                            }
                            
                            Spacer()
                            
                            NavigationLink {
                                SettingsView()
                            } label: {
                                Image (systemName: "gearshape.fill")
                                    .padding()
                                    .font(.system(size: 40))
                                    .foregroundColor(Color.bluePrimary)
                            }
                        }
                        
                        MenuCaroussel()
                        
                        VStack(alignment: .leading) {
                            
                            Text("Stories")
                                .font(.title)
                                .bold()
                            
                            ScrollView(.horizontal) {
                                HStack (spacing: 20) {
                                    ForEach(stories) { story in
                                        Image(story.imageName)
                                            .resizable()
                                            .scaledToFit()
                                    }.frame(width: 320, height: 200)
                                        .background(Color.gray.opacity(0.2))
                                        .cornerRadius(30)
                                }
                            }
                        }
                        .padding(.leading)
                    }
                    .ignoresSafeArea()
                    .edgesIgnoringSafeArea(.all)
                    .padding()
                    .background(Color.white)
                    .onAppear {
                        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                            toggleRotation.toggle()
                        }
                    }
                    
                    .navigationDestination(for: Route.self) { route in
                        router.destination(for: route)
                    }
                }
                .navigationBarHidden(true)
            }
            .environmentObject(router)
        }
*/
    }
}


#Preview {
    MenuView()
        .environmentObject(NavigationRouter())
        .environmentObject(OstomyViewModel(ostomy: loadOstomyFromBundle() ?? defaultOstomy))
}
