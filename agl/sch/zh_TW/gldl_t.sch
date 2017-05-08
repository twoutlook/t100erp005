/* 
================================================================================
檔案代號:gldl_t
檔案名稱:合併報表會計科目沖銷規則_MULTI對沖科目資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gldl_t
(
gldlent       number(5)      ,/* 企業代碼 */
gldl001       varchar2(10)      ,/* 公司編號(來源 */
gldl002       varchar2(5)      ,/* 合併帳別(來源) */
gldl003       varchar2(10)      ,/* 公司編號(對沖公司) */
gldl004       varchar2(5)      ,/* 合併帳別(對沖) */
gldl005       varchar2(10)      ,/* 上層公司(合併主體) */
gldl006       varchar2(5)      ,/* 合併帳別(合併主體) */
gldl007       number(10,0)      ,/* 沖銷組別序號 */
gldl008       varchar2(24)      ,/* MULTI科目設定值(對沖公司) */
gldl009       varchar2(24)      ,/* 科目編號 */
gldl010       varchar2(1)      ,/* 是否依據公式設定 */
gldlownid       varchar2(20)      ,/* 資料所有者 */
gldlowndp       varchar2(10)      ,/* 資料所屬部門 */
gldlcrtid       varchar2(20)      ,/* 資料建立者 */
gldlcrtdp       varchar2(10)      ,/* 資料建立部門 */
gldlcrtdt       timestamp(0)      ,/* 資料創建日 */
gldlmodid       varchar2(20)      ,/* 資料修改者 */
gldlmoddt       timestamp(0)      ,/* 最近修改日 */
gldlstus       varchar2(10)      ,/* 狀態碼 */
gldlud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gldlud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gldlud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gldlud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gldlud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gldlud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gldlud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gldlud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gldlud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gldlud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gldlud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gldlud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gldlud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gldlud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gldlud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gldlud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gldlud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gldlud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gldlud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gldlud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gldlud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gldlud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gldlud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gldlud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gldlud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gldlud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gldlud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gldlud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gldlud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gldlud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gldl_t add constraint gldl_pk primary key (gldlent,gldl001,gldl002,gldl003,gldl004,gldl005,gldl006,gldl007,gldl008,gldl009) enable validate;

create unique index gldl_pk on gldl_t (gldlent,gldl001,gldl002,gldl003,gldl004,gldl005,gldl006,gldl007,gldl008,gldl009);

grant select on gldl_t to tiptop;
grant update on gldl_t to tiptop;
grant delete on gldl_t to tiptop;
grant insert on gldl_t to tiptop;

exit;
