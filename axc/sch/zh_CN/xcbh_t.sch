/* 
================================================================================
檔案代號:xcbh_t
檔案名稱:在制報工和統計單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table xcbh_t
(
xcbhent       number(5)      ,/* 企業編號 */
xcbhsite       varchar2(10)      ,/* 營運組織 */
xcbhcomp       varchar2(10)      ,/* 法人組織 */
xcbhdocno       varchar2(20)      ,/* 單據編號 */
xcbh001       date      ,/* 日期 */
xcbh002       varchar2(80)      ,/* 備註 */
xcbhownid       varchar2(20)      ,/* 資料所有者 */
xcbhowndp       varchar2(10)      ,/* 資料所屬部門 */
xcbhcrtid       varchar2(20)      ,/* 資料建立者 */
xcbhcrtdp       varchar2(10)      ,/* 資料建立部門 */
xcbhcrtdt       timestamp(0)      ,/* 資料創建日 */
xcbhmodid       varchar2(20)      ,/* 資料修改者 */
xcbhmoddt       timestamp(0)      ,/* 最近修改日 */
xcbhcnfid       varchar2(20)      ,/* 資料確認者 */
xcbhcnfdt       timestamp(0)      ,/* 資料確認日 */
xcbhpstid       varchar2(20)      ,/* 資料過帳者 */
xcbhpstdt       timestamp(0)      ,/* 資料過帳日 */
xcbhstus       varchar2(10)      ,/* 狀態碼 */
xcbhud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xcbhud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xcbhud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xcbhud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xcbhud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xcbhud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xcbhud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xcbhud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xcbhud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xcbhud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xcbhud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xcbhud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xcbhud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xcbhud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xcbhud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xcbhud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xcbhud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xcbhud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xcbhud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xcbhud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xcbhud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xcbhud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xcbhud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xcbhud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xcbhud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xcbhud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xcbhud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xcbhud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xcbhud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xcbhud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xcbh_t add constraint xcbh_pk primary key (xcbhent,xcbhdocno) enable validate;

create unique index xcbh_pk on xcbh_t (xcbhent,xcbhdocno);

grant select on xcbh_t to tiptop;
grant update on xcbh_t to tiptop;
grant delete on xcbh_t to tiptop;
grant insert on xcbh_t to tiptop;

exit;
