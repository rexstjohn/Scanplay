using UnityEngine;
using System.Collections;
 
public class DrawLineScript : MonoBehaviour {
    public Color c1 = Color.yellow;
    public Color c2 = Color.red;
    private ArrayList lstNumbers = new ArrayList();
    //var lineArray= new Array();
    public int lengthOfLineRenderer = 20;
    void Start() {
        LineRenderer lineRenderer = gameObject.AddComponent<LineRenderer>();
        lineRenderer.material = new Material(Shader.Find("Particles/Additive"));
        lineRenderer.SetColors(c1, c2);
        lineRenderer.SetWidth(0.02f, 0.02f);
        lineRenderer.SetVertexCount(lengthOfLineRenderer);
    }
    void Update() {
         if(Input.GetMouseButton(0)){
        //  if ( iPhoneInput.GetTouch(0).phase == iPhoneTouchPhase.Moved) {
 
                Vector3 mousePos=Input.mousePosition; //iPhoneInput.GetTouch(0).deltaPosition;
                // lineArray.Push(touchDeltaPosition);
 
            mousePos.z = 1f;
Vector3 worldPos = Camera.main.ScreenToWorldPoint(mousePos);
 
            Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
 
//Vector3 worldPos = ray.
 
                lstNumbers.Add(worldPos);//452.35);
 
        }
 
                Drawline();
    }
    // -------------------------------------
    void Drawline() {
        LineRenderer lineRenderer = GetComponent<LineRenderer>();
        int t_len=lstNumbers.Count;
 
      if(t_len>0){
      lineRenderer.SetVertexCount(t_len);//lengthOfLineRenderer);
 
            //lineRenderer.Size=t_len;
            for(int a=0;a<t_len;a++){
                Vector3 t1=(Vector3)lstNumbers[a];
                //t1.z=0;
                lineRenderer.SetPosition(a,t1);
            }
 
      if(t_len>20){
            lstNumbers.RemoveAt(0);
            }
 
        }
 
    }
}