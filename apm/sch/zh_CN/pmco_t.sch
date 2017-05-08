/* 
================================================================================
檔案代號:pmco_t
檔案名稱:鋪貨單單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table pmco_t
(
pmcoent       number(5)      ,/* 企業編號 */
pmcosite       varchar2(10)      ,/* 營運據點 */
pmcounit       varchar2(10)      ,/* 應用組織 */
pmcodocno       varchar2(20)      ,/* 鋪貨單號 */
pmcodocdt       date      ,/* 單據日期 */
pmco001       varchar2(20)      ,/* 申請人員 */
pmco002       varchar2(10)      ,/* 申請部門 */
pmco003       date      ,/* 執行日期 */
pmco004       date      ,/* 到貨日期 */
pmco005       varchar2(255)      ,/* 備註 */
pmcoownid       varchar2(20)      ,/* 資料所有者 */
pmcoowndp       varchar2(10)      ,/* 資料所屬部門 */
pmcocrtid       varchar2(20)      ,/* 資料建立者 */
pmcocrtdp       varchar2(10)      ,/* 資料建立部門 */
pmcocrtdt       timestamp(0)      ,/* 資料創建日 */
pmcomodid       varchar2(20)      ,/* 資料修改者 */
pmcomoddt       timestamp(0)      ,/* 最近修改日 */
pmcostus       varchar2(10)      ,/* 狀態碼 */
pmcocnfid       varchar2(20)      ,/* 資料確認者 */
pmcocnfdt       timestamp(0)      ,/* 資料確認日 */
pmcoud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmcoud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmcoud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmcoud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmcoud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmcoud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmcoud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmcoud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmcoud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmcoud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmcoud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmcoud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmcoud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmcoud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmcoud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmcoud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmcoud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmcoud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmcoud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmcoud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmcoud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmcoud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmcoud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmcoud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmcoud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmcoud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmcoud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmcoud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmcoud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmcoud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmco_t add constraint pmco_pk primary key (pmcoent,pmcodocno) enable validate;

create unique index pmco_pk on pmco_t (pmcoent,pmcodocno);

grant select on pmco_t to tiptop;
grant update on pmco_t to tiptop;
grant delete on pmco_t to tiptop;
grant insert on pmco_t to tiptop;

exit;
