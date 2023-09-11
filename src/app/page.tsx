import Header from "@/components/header.components";

export default async function Home() {
  return (
    <>
      <Header />
      <section className="bg-ct-blue-600 min-h-screen pt-20">
        <div className="max-w-4xl mx-auto bg-ct-dark-100 rounded-md h-[20rem] flex justify-center items-center">
          <p className="text-3xl font-semibold">
            Une petite application de test pour voir comment se passe la connection avec Next-Auth !
          </p>
        </div>
      </section>
    </>
  );
}
