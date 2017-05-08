/* 
================================================================================
檔案代號:qcad_t
檔案名稱:1916檢驗水準計數值樣本代碼檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table qcad_t
(
qcadstus       varchar2(10)      ,/* 狀態碼 */
qcadent       number(5)      ,/* 企業編號 */
qcad001       varchar2(10)      ,/* 級數 */
qcad002       varchar2(1)      ,/* 樣本字號 */
qcad003       number(10,0)      ,/* 起始批量 */
qcad004       number(10,0)      ,/* 截止批量 */
qcadownid       varchar2(20)      ,/* 資料所有者 */
qcadowndp       varchar2(10)      ,/* 資料所屬部門 */
qcadcrtid       varchar2(20)      ,/* 資料建立者 */
qcadcrtdp       varchar2(10)      ,/* 資料建立部門 */
qcadcrtdt       timestamp(0)      ,/* 資料創建日 */
qcadmodid       varchar2(20)      ,/* 資料修改者 */
qcadmoddt       timestamp(0)      ,/* 最近修改日 */
qcadud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
qcadud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
qcadud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
qcadud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
qcadud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
qcadud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
qcadud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
qcadud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
qcadud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
qcadud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
qcadud011       number(20,6)      ,/* 自定義欄位(數字)011 */
qcadud012       number(20,6)      ,/* 自定義欄位(數字)012 */
qcadud013       number(20,6)      ,/* 自定義欄位(數字)013 */
qcadud014       number(20,6)      ,/* 自定義欄位(數字)014 */
qcadud015       number(20,6)      ,/* 自定義欄位(數字)015 */
qcadud016       number(20,6)      ,/* 自定義欄位(數字)016 */
qcadud017       number(20,6)      ,/* 自定義欄位(數字)017 */
qcadud018       number(20,6)      ,/* 自定義欄位(數字)018 */
qcadud019       number(20,6)      ,/* 自定義欄位(數字)019 */
qcadud020       number(20,6)      ,/* 自定義欄位(數字)020 */
qcadud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
qcadud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
qcadud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
qcadud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
qcadud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
qcadud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
qcadud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
qcadud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
qcadud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
qcadud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table qcad_t add constraint qcad_pk primary key (qcadent,qcad001,qcad002,qcad003) enable validate;

create unique index qcad_pk on qcad_t (qcadent,qcad001,qcad002,qcad003);

grant select on qcad_t to tiptop;
grant update on qcad_t to tiptop;
grant delete on qcad_t to tiptop;
grant insert on qcad_t to tiptop;

exit;
