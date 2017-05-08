/* 
================================================================================
檔案代號:srba_t
檔案名稱:重覆性生產期末盤點單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table srba_t
(
srbaent       number(5)      ,/* 企業編號 */
srbasite       varchar2(10)      ,/* 營運據點 */
srbadocno       varchar2(20)      ,/* 盤點單號 */
srbadocdt       date      ,/* 盤點日期 */
srba001       date      ,/* 起始日期 */
srba002       date      ,/* 截止日期 */
srba003       varchar2(10)      ,/* 生產計劃 */
srba004       varchar2(10)      ,/* 分攤方式 */
srba005       varchar2(10)      ,/* 庫位 */
srba006       varchar2(10)      ,/* 儲位 */
srbaownid       varchar2(20)      ,/* 資料所有者 */
srbaowndp       varchar2(10)      ,/* 資料所屬部門 */
srbacrtid       varchar2(20)      ,/* 資料建立者 */
srbacrtdp       varchar2(10)      ,/* 資料建立部門 */
srbacrtdt       timestamp(0)      ,/* 資料創建日 */
srbamodid       varchar2(20)      ,/* 資料修改者 */
srbamoddt       timestamp(0)      ,/* 最近修改日 */
srbacnfid       varchar2(20)      ,/* 資料確認者 */
srbacnfdt       timestamp(0)      ,/* 資料確認日 */
srbapstid       varchar2(20)      ,/* 資料過帳者 */
srbapstdt       timestamp(0)      ,/* 資料過帳日 */
srbastus       varchar2(10)      ,/* 狀態碼 */
srbaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
srbaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
srbaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
srbaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
srbaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
srbaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
srbaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
srbaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
srbaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
srbaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
srbaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
srbaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
srbaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
srbaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
srbaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
srbaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
srbaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
srbaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
srbaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
srbaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
srbaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
srbaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
srbaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
srbaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
srbaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
srbaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
srbaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
srbaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
srbaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
srbaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table srba_t add constraint srba_pk primary key (srbaent,srbadocno) enable validate;

create unique index srba_pk on srba_t (srbaent,srbadocno);

grant select on srba_t to tiptop;
grant update on srba_t to tiptop;
grant delete on srba_t to tiptop;
grant insert on srba_t to tiptop;

exit;
