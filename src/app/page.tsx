import Header from "@/components/header.components";
import { authOptions } from "@/lib/auth";
import { getServerSession } from "next-auth";

export default async function Home() {
  // const session = getServerSession(context.req, context.res, authOptions)
  // console.log("hello world", session)

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
