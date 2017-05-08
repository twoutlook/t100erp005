/* 
================================================================================
檔案代號:mmbf_t
檔案名稱:會員卡資料開帳單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table mmbf_t
(
mmbfent       number(5)      ,/* 企業編號 */
mmbfunit       varchar2(10)      ,/* 應用組織 */
mmbfsite       varchar2(10)      ,/* 營運據點 */
mmbfdocno       varchar2(20)      ,/* 單號 */
mmbfdocdt       date      ,/* 單據日期 */
mmbf001       varchar2(10)      ,/* 理由碼 */
mmbfownid       varchar2(20)      ,/* 資料所有者 */
mmbfowndp       varchar2(10)      ,/* 資料所屬部門 */
mmbfcrtid       varchar2(20)      ,/* 資料建立者 */
mmbfcrtdp       varchar2(10)      ,/* 資料建立部門 */
mmbfcrtdt       timestamp(0)      ,/* 資料創建日 */
mmbfmodid       varchar2(20)      ,/* 資料修改者 */
mmbfmoddt       timestamp(0)      ,/* 最近修改日 */
mmbfstus       varchar2(10)      ,/* 狀態碼 */
mmbfcnfid       varchar2(20)      ,/* 資料確認者 */
mmbfcnfdt       timestamp(0)      ,/* 資料確認日 */
mmbfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmbfud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmbfud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmbfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmbfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmbfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmbfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmbfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmbfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmbfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmbfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmbfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmbfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmbfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmbfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmbfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmbfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmbfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmbfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmbfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmbfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmbfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmbfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmbfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmbfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmbfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmbfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmbfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmbfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmbfud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmbf_t add constraint mmbf_pk primary key (mmbfent,mmbfdocno) enable validate;

create unique index mmbf_pk on mmbf_t (mmbfent,mmbfdocno);

grant select on mmbf_t to tiptop;
grant update on mmbf_t to tiptop;
grant delete on mmbf_t to tiptop;
grant insert on mmbf_t to tiptop;

exit;
