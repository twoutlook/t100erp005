/* 
================================================================================
檔案代號:qcac_t
檔案名稱:單次抽樣計劃資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table qcac_t
(
qcacstus       varchar2(10)      ,/* 狀態碼 */
qcacent       number(5)      ,/* 企業編號 */
qcac001       varchar2(10)      ,/* 檢驗程度 */
qcac002       number(7,3)      ,/* AQL */
qcac003       varchar2(1)      ,/* 樣本字號 */
qcac004       varchar2(1)      ,/* 調整樣本字號 */
qcac005       number(5,0)      ,/* 接受數量 */
qcac006       number(5,0)      ,/* 拒絕數量 */
qcacownid       varchar2(20)      ,/* 資料所有者 */
qcacowndp       varchar2(10)      ,/* 資料所屬部門 */
qcaccrtid       varchar2(20)      ,/* 資料建立者 */
qcaccrtdp       varchar2(10)      ,/* 資料建立部門 */
qcaccrtdt       timestamp(0)      ,/* 資料創建日 */
qcacmodid       varchar2(20)      ,/* 資料修改者 */
qcacmoddt       timestamp(0)      ,/* 最近修改日 */
qcacud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
qcacud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
qcacud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
qcacud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
qcacud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
qcacud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
qcacud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
qcacud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
qcacud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
qcacud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
qcacud011       number(20,6)      ,/* 自定義欄位(數字)011 */
qcacud012       number(20,6)      ,/* 自定義欄位(數字)012 */
qcacud013       number(20,6)      ,/* 自定義欄位(數字)013 */
qcacud014       number(20,6)      ,/* 自定義欄位(數字)014 */
qcacud015       number(20,6)      ,/* 自定義欄位(數字)015 */
qcacud016       number(20,6)      ,/* 自定義欄位(數字)016 */
qcacud017       number(20,6)      ,/* 自定義欄位(數字)017 */
qcacud018       number(20,6)      ,/* 自定義欄位(數字)018 */
qcacud019       number(20,6)      ,/* 自定義欄位(數字)019 */
qcacud020       number(20,6)      ,/* 自定義欄位(數字)020 */
qcacud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
qcacud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
qcacud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
qcacud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
qcacud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
qcacud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
qcacud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
qcacud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
qcacud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
qcacud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
qcac007       number(5,0)      /* 檢驗抽樣數 */
);
alter table qcac_t add constraint qcac_pk primary key (qcacent,qcac001,qcac002,qcac003) enable validate;

create unique index qcac_pk on qcac_t (qcacent,qcac001,qcac002,qcac003);

grant select on qcac_t to tiptop;
grant update on qcac_t to tiptop;
grant delete on qcac_t to tiptop;
grant insert on qcac_t to tiptop;

exit;
