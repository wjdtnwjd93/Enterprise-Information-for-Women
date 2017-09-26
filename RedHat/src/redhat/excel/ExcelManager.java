package redhat.excel;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import redhat.enterprise.EnterpriseDAO;

// 엑셀 파일 관리 객체
public class ExcelManager {
	String filePath; // 파일 경로 저장 생성자를 통해
	FileInputStream fis = null; // 입력 스트림
	HSSFWorkbook workbook = null;
	
	// 생성자
	public void openFile(String filePath) {
		
		this.filePath = filePath; // 경로 저장
		
		// 객체 생성시 파일 경로를 사용해 입력 스트림 생성
		try {
			fis = new FileInputStream(filePath);
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			workbook = new HSSFWorkbook(fis);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	// 엑셀 파일에 있는 정보를 DB에 업데이트 하는 메소드
	public void updateEntDB() {
		int rowindex=0;
		int columnindex=0;
		// 첫 번째 시트를 읽음
		HSSFSheet sheet=workbook.getSheetAt(0);
		//행의 수
		int rows=sheet.getPhysicalNumberOfRows();
		
		for(rowindex=1;rowindex<rows;rowindex++){
		    //행을 읽는다
		    HSSFRow row=sheet.getRow(rowindex);
		    if(row !=null){
		        //셀의 수
		        int cells=row.getPhysicalNumberOfCells();
	            
	            // 각 행의 기업 정보를 저장할 변수 선언
	            String entCode = "";
	            String entName = "";
	            boolean entFam = false;
	            
		        for(columnindex=0;columnindex<=cells;columnindex++){
		            //셀값 저장
		            HSSFCell cell=row.getCell(columnindex);
		            String value="";
		            
		            // 셀이 비었을 경우
		            if(cell==null){
		                continue;
		            }else{
		                // 셀 자료형별로 내용 가져오기
		                switch (cell.getCellType()){
		                case HSSFCell.CELL_TYPE_STRING: // 문자열 정보 (기업 코드, 이름)
		                    value=cell.getStringCellValue()+"";
		                    
		                    // 열 번호가 0이면 기업 코드, 1이면 기업 이름 저장
		                    // 열 번호 2에 O가 입력된 경우 가족친화기업 (true)
		                    if(columnindex==0)
		                    	entCode = value;
		                    else if(columnindex==1)
		                    	entName = value;
		                    else if(columnindex==2) {
		                    	// O인 경우 확인
		                    	if(value.equalsIgnoreCase("O")) {
		                    		entFam = true;
		                    	}
		                    }
		                    break;
		                    
		                case HSSFCell.CELL_TYPE_BLANK: // boolean 값 (가족친화)
		                    value=cell.getBooleanCellValue()+"";
		                    
		                    // 열번호가 2인 경우에 아무것도 입력 되어 있지 않은 경우
		                    // 가족친화기업 아님 (false)
		                    if(columnindex==2)
		                    	entFam = false;
		                    break;
		                    
		                case HSSFCell.CELL_TYPE_ERROR: // 에러처리
		                    value=cell.getErrorCellValue()+"";
		                    break;
		                }
		            }
		             
		        }
		        // console 확인
	            System.out.println("기업코드:"+ entCode + " / 기업이름:"+ entName + " / 가족친화:" + entFam);
	            
	            // SQL문을 이용해 DB에 엑셀 데이터 insert
	            // 기업정보 DB 객체 생성
	            EnterpriseDAO db = new EnterpriseDAO();
	            // DB에 insert 하기
	            db.insertEntData(entCode, entName, entFam);
		    }
		}
	}
}

