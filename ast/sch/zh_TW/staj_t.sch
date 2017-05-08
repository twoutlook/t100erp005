/* 
================================================================================
檔案代號:staj_t
檔案名稱:自營合約異動申請單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table staj_t
(
stajent       number(5)      ,/* 企業編號 */
stajunit       varchar2(10)      ,/* 應用組織 */
stajsite       varchar2(10)      ,/* 營運據點 */
stajdocno       varchar2(20)      ,/* 單號 */
stajdocdt       date      ,/* 單據日期 */
staj000       varchar2(10)      ,/* 作業方式 */
staj001       varchar2(20)      ,/* 合約編號 */
staj002       varchar2(10)      ,/* 經營方式 */
staj003       varchar2(10)      ,/* 版本 */
staj004       varchar2(10)      ,/* 模板編號 */
staj005       varchar2(10)      ,/* 供應商編號 */
staj006       varchar2(10)      ,/* 幣別 */
staj007       varchar2(10)      ,/* 稅別 */
staj008       varchar2(10)      ,/* 收付款方式 */
staj009       varchar2(10)      ,/* 結算方式 */
staj010       varchar2(10)      ,/* 結算類別 */
staj011       varchar2(1)      ,/* 訂貨滿足率 */
staj012       date      ,/* 簽訂日期 */
staj013       varchar2(10)      ,/* 簽訂法人 */
staj014       varchar2(20)      ,/* 簽訂人員 */
staj015       varchar2(10)      ,/* 結算中心 */
staj016       varchar2(10)      ,/* 採購中心 */
staj017       date      ,/* 生效日期 */
staj018       date      ,/* 失效日期 */
staj019       date      ,/* 清退日期 */
staj020       date      ,/* 作廢日期 */
staj021       varchar2(20)      ,/* 文檔編號 */
staj022       varchar2(10)      ,/* 申請組織 */
stajacti       varchar2(1)      ,/* 合約有效碼 */
stajownid       varchar2(20)      ,/* 資料所有者 */
stajowndp       varchar2(10)      ,/* 資料所有部門 */
stajcrtid       varchar2(20)      ,/* 資料建立者 */
stajcrtdp       varchar2(10)      ,/* 資料建立部門 */
stajcrtdt       timestamp(0)      ,/* 資料創建日 */
stajmodid       varchar2(20)      ,/* 資料修改者 */
stajmoddt       timestamp(0)      ,/* 最近修改日 */
stajstus       varchar2(10)      ,/* 狀態碼 */
stajcnfid       varchar2(20)      ,/* 資料確認者 */
stajcnfdt       timestamp(0)      ,/* 資料確認日 */
stajud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stajud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stajud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stajud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stajud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stajud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stajud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stajud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stajud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stajud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stajud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stajud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stajud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stajud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stajud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stajud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stajud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stajud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stajud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stajud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stajud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stajud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stajud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stajud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stajud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stajud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stajud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stajud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stajud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stajud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
staj023       varchar2(20)      ,/* 來源單號 */
staj024       varchar2(10)      ,/* 交易條件 */
staj025       varchar2(2)      ,/* 發票類型 */
staj026       varchar2(1)      ,/* 採購價格允許人工修改 */
staj027       number(20,6)      ,/* 修改容差率 */
staj028       varchar2(10)      ,/* 超出處理方式 */
staj029       varchar2(10)      ,/* 內外購 */
staj030       varchar2(10)      ,/* 匯率計算基準 */
staj031       varchar2(10)      ,/* 合約狀態 */
staj032       varchar2(20)      ,/* 原合同編號 */
staj033       date      ,/* 延期日期 */
staj034       varchar2(10)      ,/* 收銀方式 */
staj035       date      ,/* 續期日期 */
staj036       varchar2(1)      ,/* 文本蓋章否 */
staj037       date      ,/* 蓋章日期 */
staj038       varchar2(255)      ,/* 備註 */
staj039       date      ,/* 執行日期 */
staj040       varchar2(1)      ,/* 含發票否 */
staj041       varchar2(10)      ,/* 部門 */
staj042       varchar2(1)      /* 按法人結算 */
);
alter table staj_t add constraint staj_pk primary key (stajent,stajdocno) enable validate;

create unique index staj_pk on staj_t (stajent,stajdocno);

grant select on staj_t to tiptop;
grant update on staj_t to tiptop;
grant delete on staj_t to tiptop;
grant insert on staj_t to tiptop;

exit;
