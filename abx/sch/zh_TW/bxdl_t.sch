/* 
================================================================================
檔案代號:bxdl_t
檔案名稱:保稅機器設備報廢/除帳單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table bxdl_t
(
bxdlent       number(5)      ,/* 企業編號 */
bxdlsite       varchar2(10)      ,/* 營運據點 */
bxdldocno       varchar2(20)      ,/* 報廢/除帳單號 */
bxdldocdt       date      ,/* 單據日期 */
bxdl000       varchar2(10)      ,/* 性質 */
bxdl001       varchar2(20)      ,/* 申請人員 */
bxdl002       varchar2(10)      ,/* 申請部門 */
bxdl010       varchar2(255)      ,/* 備註 */
bxdlownid       varchar2(20)      ,/* 資料所有者 */
bxdlowndp       varchar2(10)      ,/* 資料所屬部門 */
bxdlcrtid       varchar2(20)      ,/* 資料建立者 */
bxdlcrtdp       varchar2(10)      ,/* 資料建立部門 */
bxdlcrtdt       timestamp(0)      ,/* 資料創建日 */
bxdlmodid       varchar2(20)      ,/* 資料修改者 */
bxdlmoddt       timestamp(0)      ,/* 最近修改日 */
bxdlcnfid       varchar2(20)      ,/* 資料確認者 */
bxdlcnfdt       timestamp(0)      ,/* 資料確認日 */
bxdlstus       varchar2(10)      ,/* 狀態碼 */
bxdlud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bxdlud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bxdlud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bxdlud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bxdlud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bxdlud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bxdlud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bxdlud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bxdlud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bxdlud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bxdlud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bxdlud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bxdlud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bxdlud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bxdlud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bxdlud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bxdlud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bxdlud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bxdlud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bxdlud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bxdlud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bxdlud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bxdlud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bxdlud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bxdlud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bxdlud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bxdlud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bxdlud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bxdlud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bxdlud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bxdl_t add constraint bxdl_pk primary key (bxdlent,bxdldocno) enable validate;

create unique index bxdl_pk on bxdl_t (bxdlent,bxdldocno);

grant select on bxdl_t to tiptop;
grant update on bxdl_t to tiptop;
grant delete on bxdl_t to tiptop;
grant insert on bxdl_t to tiptop;

exit;
