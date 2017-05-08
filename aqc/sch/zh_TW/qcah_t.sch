/* 
================================================================================
檔案代號:qcah_t
檔案名稱:QC抽樣自定義資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table qcah_t
(
qcahent       number(5)      ,/* 企業編號 */
qcah001       varchar2(5)      ,/* 品管參照表號 */
qcah002       number(7,3)      ,/* AQL */
qcah003       varchar2(10)      ,/* 檢驗程度 */
qcah004       number(20,6)      ,/* 起始批量 */
qcah005       number(20,6)      ,/* 截止批量 */
qcah006       number(20,6)      ,/* 抽樣數 */
qcah007       number(20,6)      ,/* 允收數 */
qcahownid       varchar2(20)      ,/* 資料所有者 */
qcahowndp       varchar2(10)      ,/* 資料所屬部門 */
qcahcrtid       varchar2(20)      ,/* 資料建立者 */
qcahcrtdp       varchar2(10)      ,/* 資料建立部門 */
qcahcrtdt       timestamp(0)      ,/* 資料創建日 */
qcahmodid       varchar2(20)      ,/* 資料修改者 */
qcahmoddt       timestamp(0)      ,/* 最近修改日 */
qcahstus       varchar2(10)      ,/* 狀態碼 */
qcahud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
qcahud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
qcahud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
qcahud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
qcahud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
qcahud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
qcahud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
qcahud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
qcahud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
qcahud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
qcahud011       number(20,6)      ,/* 自定義欄位(數字)011 */
qcahud012       number(20,6)      ,/* 自定義欄位(數字)012 */
qcahud013       number(20,6)      ,/* 自定義欄位(數字)013 */
qcahud014       number(20,6)      ,/* 自定義欄位(數字)014 */
qcahud015       number(20,6)      ,/* 自定義欄位(數字)015 */
qcahud016       number(20,6)      ,/* 自定義欄位(數字)016 */
qcahud017       number(20,6)      ,/* 自定義欄位(數字)017 */
qcahud018       number(20,6)      ,/* 自定義欄位(數字)018 */
qcahud019       number(20,6)      ,/* 自定義欄位(數字)019 */
qcahud020       number(20,6)      ,/* 自定義欄位(數字)020 */
qcahud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
qcahud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
qcahud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
qcahud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
qcahud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
qcahud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
qcahud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
qcahud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
qcahud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
qcahud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table qcah_t add constraint qcah_pk primary key (qcahent,qcah001,qcah002,qcah003,qcah004,qcah005) enable validate;

create unique index qcah_pk on qcah_t (qcahent,qcah001,qcah002,qcah003,qcah004,qcah005);

grant select on qcah_t to tiptop;
grant update on qcah_t to tiptop;
grant delete on qcah_t to tiptop;
grant insert on qcah_t to tiptop;

exit;
