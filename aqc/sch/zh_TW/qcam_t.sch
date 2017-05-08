/* 
================================================================================
檔案代號:qcam_t
檔案名稱:品質檢驗項目單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table qcam_t
(
qcament       number(5)      ,/* 企業編號 */
qcam001       varchar2(5)      ,/* 參照表號 */
qcam002       varchar2(10)      ,/* 品管分群 */
qcam003       varchar2(40)      ,/* 料件編號 */
qcam004       varchar2(256)      ,/* 產品特徵 */
qcam005       varchar2(10)      ,/* 作業編號 */
qcam006       number(10,0)      ,/* 加工序 */
qcam007       varchar2(10)      ,/* 交易對象類型 */
qcam008       varchar2(10)      ,/* 交易對象編號 */
qcam009       varchar2(10)      ,/* 檢驗類型 */
qcam010       varchar2(20)      ,/* 識別碼 */
qcamownid       varchar2(20)      ,/* 資料所有者 */
qcamowndp       varchar2(10)      ,/* 資料所屬部門 */
qcamcrtid       varchar2(20)      ,/* 資料建立者 */
qcamcrtdp       varchar2(10)      ,/* 資料建立部門 */
qcamcrtdt       timestamp(0)      ,/* 資料創建日 */
qcammodid       varchar2(20)      ,/* 資料修改者 */
qcammoddt       timestamp(0)      ,/* 最近修改日 */
qcamstus       varchar2(10)      ,/* 狀態碼 */
qcamud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
qcamud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
qcamud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
qcamud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
qcamud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
qcamud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
qcamud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
qcamud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
qcamud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
qcamud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
qcamud011       number(20,6)      ,/* 自定義欄位(數字)011 */
qcamud012       number(20,6)      ,/* 自定義欄位(數字)012 */
qcamud013       number(20,6)      ,/* 自定義欄位(數字)013 */
qcamud014       number(20,6)      ,/* 自定義欄位(數字)014 */
qcamud015       number(20,6)      ,/* 自定義欄位(數字)015 */
qcamud016       number(20,6)      ,/* 自定義欄位(數字)016 */
qcamud017       number(20,6)      ,/* 自定義欄位(數字)017 */
qcamud018       number(20,6)      ,/* 自定義欄位(數字)018 */
qcamud019       number(20,6)      ,/* 自定義欄位(數字)019 */
qcamud020       number(20,6)      ,/* 自定義欄位(數字)020 */
qcamud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
qcamud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
qcamud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
qcamud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
qcamud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
qcamud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
qcamud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
qcamud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
qcamud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
qcamud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table qcam_t add constraint qcam_pk primary key (qcament,qcam001,qcam002,qcam003,qcam004,qcam005,qcam006,qcam008,qcam009) enable validate;

create  index qcam_01 on qcam_t (qcam010);
create unique index qcam_pk on qcam_t (qcament,qcam001,qcam002,qcam003,qcam004,qcam005,qcam006,qcam008,qcam009);

grant select on qcam_t to tiptop;
grant update on qcam_t to tiptop;
grant delete on qcam_t to tiptop;
grant insert on qcam_t to tiptop;

exit;
