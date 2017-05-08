/* 
================================================================================
檔案代號:mmbh_t
檔案名稱:會員卡積點調整單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table mmbh_t
(
mmbhent       number(5)      ,/* 企業編號 */
mmbhdocno       varchar2(20)      ,/* 單號 */
mmbhsite       varchar2(10)      ,/* 營運據點 */
mmbhunit       varchar2(10)      ,/* 應用組織 */
mmbhdocdt       date      ,/* 單據日期 */
mmbh001       varchar2(10)      ,/* 理由碼 */
mmbh002       varchar2(10)      ,/* 異動來源 */
mmbhstus       varchar2(10)      ,/* 狀態碼 */
mmbhownid       varchar2(20)      ,/* 資料所有者 */
mmbhowndp       varchar2(10)      ,/* 資料所屬部門 */
mmbhcrtid       varchar2(20)      ,/* 資料建立者 */
mmbhcrtdp       varchar2(10)      ,/* 資料建立部門 */
mmbhcrtdt       timestamp(0)      ,/* 資料創建日 */
mmbhmodid       varchar2(20)      ,/* 資料修改者 */
mmbhmoddt       timestamp(0)      ,/* 最近修改日 */
mmbhcnfid       varchar2(20)      ,/* 資料確認者 */
mmbhcnfdt       timestamp(0)      ,/* 資料確認日 */
mmbhud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmbhud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmbhud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmbhud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmbhud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmbhud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmbhud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmbhud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmbhud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmbhud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmbhud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmbhud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmbhud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmbhud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmbhud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmbhud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmbhud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmbhud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmbhud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmbhud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmbhud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmbhud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmbhud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmbhud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmbhud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmbhud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmbhud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmbhud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmbhud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmbhud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
mmbh003       varchar2(255)      ,/* 備註 */
mmbh000       varchar2(20)      /* 程式編號 */
);
alter table mmbh_t add constraint mmbh_pk primary key (mmbhent,mmbhdocno) enable validate;

create unique index mmbh_pk on mmbh_t (mmbhent,mmbhdocno);

grant select on mmbh_t to tiptop;
grant update on mmbh_t to tiptop;
grant delete on mmbh_t to tiptop;
grant insert on mmbh_t to tiptop;

exit;
