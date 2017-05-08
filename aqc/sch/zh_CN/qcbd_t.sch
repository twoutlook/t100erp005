/* 
================================================================================
檔案代號:qcbd_t
檔案名稱:品質檢驗單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table qcbd_t
(
qcbdent       number(5)      ,/* 企業編號 */
qcbdsite       varchar2(10)      ,/* 營運據點 */
qcbddocno       varchar2(20)      ,/* 單號 */
qcbdseq       number(10,0)      ,/* 行序 */
qcbd001       varchar2(10)      ,/* 檢驗項目 */
qcbd002       varchar2(40)      ,/* 檢驗位置 */
qcbd003       varchar2(10)      ,/* 缺點等級 */
qcbd004       number(7,3)      ,/* AQL */
qcbd005       number(20,6)      ,/* 允收數 */
qcbd006       number(20,6)      ,/* 拒絕數 */
qcbd007       number(5,3)      ,/* K法標准值 */
qcbd008       number(5,3)      ,/* F法標准值 */
qcbd009       number(20,6)      ,/* 抽驗量 */
qcbd010       number(20,6)      ,/* 缺點數 */
qcbd011       varchar2(10)      ,/* 項目判定結果 */
qcbd012       number(15,3)      ,/* 規範上限 */
qcbd013       number(15,3)      ,/* 檢驗上限 */
qcbd014       number(15,3)      ,/* 檢驗標準值 */
qcbd015       number(15,3)      ,/* 檢驗下限 */
qcbd016       number(15,3)      ,/* 規範下限 */
qcbd017       varchar2(10)      ,/* 計量單位 */
qcbd018       varchar2(255)      ,/* 檢驗規格說明 */
qcbd019       varchar2(255)      ,/* 備註 */
qcbd020       varchar2(10)      ,/* 抽樣計畫 */
qcbd021       number(20,6)      ,/* 不良數 */
qcbdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
qcbdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
qcbdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
qcbdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
qcbdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
qcbdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
qcbdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
qcbdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
qcbdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
qcbdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
qcbdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
qcbdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
qcbdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
qcbdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
qcbdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
qcbdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
qcbdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
qcbdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
qcbdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
qcbdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
qcbdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
qcbdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
qcbdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
qcbdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
qcbdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
qcbdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
qcbdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
qcbdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
qcbdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
qcbdud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table qcbd_t add constraint qcbd_pk primary key (qcbdent,qcbddocno,qcbdseq) enable validate;

create unique index qcbd_pk on qcbd_t (qcbdent,qcbddocno,qcbdseq);

grant select on qcbd_t to tiptop;
grant update on qcbd_t to tiptop;
grant delete on qcbd_t to tiptop;
grant insert on qcbd_t to tiptop;

exit;
