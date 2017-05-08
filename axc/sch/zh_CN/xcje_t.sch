/* 
================================================================================
檔案代號:xcje_t
檔案名稱:內部收入成本數據單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table xcje_t
(
xcjeent       number(5)      ,/* 企業編號 */
xcjesite       varchar2(10)      ,/* 賬務中心 */
xcjeld       varchar2(5)      ,/* 帳套 */
xcjedocno       varchar2(20)      ,/* 單據編號 */
xcjedocdt       date      ,/* 單據日期 */
xcje001       varchar2(1)      ,/* 來源類型 */
xcje002       number(5,0)      ,/* 年度 */
xcje003       number(5,0)      ,/* 期別 */
xcje004       varchar2(20)      ,/* 憑證號碼 */
xcje005       date      ,/* 憑證日期 */
xcje006       varchar2(10)      ,/* 計算類型(版本) */
xcje007       varchar2(20)      ,/* 賬務人員 */
xcjeownid       varchar2(20)      ,/* 資料所有者 */
xcjeowndp       varchar2(10)      ,/* 資料所屬部門 */
xcjecrtid       varchar2(20)      ,/* 資料建立者 */
xcjecrtdp       varchar2(10)      ,/* 資料建立部門 */
xcjecrtdt       timestamp(0)      ,/* 資料創建日 */
xcjemodid       varchar2(20)      ,/* 資料修改者 */
xcjemoddt       timestamp(0)      ,/* 最近修改日 */
xcjecnfid       varchar2(20)      ,/* 資料確認者 */
xcjecnfdt       timestamp(0)      ,/* 資料確認日 */
xcjepstid       varchar2(20)      ,/* 資料過帳者 */
xcjepstdt       timestamp(0)      ,/* 資料過帳日 */
xcjestus       varchar2(10)      ,/* 狀態碼 */
xcjeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xcjeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xcjeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xcjeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xcjeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xcjeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xcjeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xcjeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xcjeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xcjeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xcjeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xcjeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xcjeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xcjeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xcjeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xcjeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xcjeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xcjeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xcjeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xcjeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xcjeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xcjeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xcjeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xcjeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xcjeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xcjeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xcjeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xcjeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xcjeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xcjeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xcje_t add constraint xcje_pk primary key (xcjeent,xcjeld,xcjedocno) enable validate;

create unique index xcje_pk on xcje_t (xcjeent,xcjeld,xcjedocno);

grant select on xcje_t to tiptop;
grant update on xcje_t to tiptop;
grant delete on xcje_t to tiptop;
grant insert on xcje_t to tiptop;

exit;
