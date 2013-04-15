package br.inf.intelidata.appteste;
import android.os.Bundle;
public class Appteste extends DashboardActivity{

    @override
    protected void onCreate(Bundle savedInstanceState){
        super.onCreate(savedInstanceState);
        setContentView(R.layout.appteste);
    }

    @override
    public void goHome(Context context){
        final Intent intent = new Intent(context, Appteste.class);
        intent.setFlags (Intent.FLAG_ACTIVITY_CLEAR_TOP);
        context.startActivity (intent);
    }

    @override
    public void onClickFeature (View v){
        int id = v.getId ();
        switch (id) {
        case R.id.home_btn_feature1 :
            startActivity (new Intent(getApplicationContext(), ClienteLST.class));
            break;
        case R.id.home_btn_feature1 :
            startActivity (new Intent(getApplicationContext(), ProdutoLST.class));
            break;
        default:
            break;
    }
}
