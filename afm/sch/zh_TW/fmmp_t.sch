/* 
================================================================================
檔案代號:fmmp_t
檔案名稱:期末公允價值檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table fmmp_t
(
fmmpent       number(5)      ,/* 企業編號 */
fmmpsite       varchar2(10)      ,/* 帳務中心 */
fmmpld       varchar2(5)      ,/* 帳套 */
fmmp001       number(5,0)      ,/* 年度 */
fmmp002       number(5,0)      ,/* 期別 */
fmmp003       varchar2(10)      ,/* 投資組織 */
fmmp004       varchar2(20)      ,/* 投資購買單號 */
fmmp005       number(20,6)      ,/* 留倉數量 */
fmmp006       number(20,6)      ,/* 留倉金額 */
fmmp007       number(20,6)      ,/* 期末公允單價 */
fmmp008       number(20,6)      ,/* 期末公允價值 */
fmmp009       number(20,6)      ,/* 差額 */
fmmpownid       varchar2(20)      ,/* 資料所有者 */
fmmpowndp       varchar2(10)      ,/* 資料所屬部門 */
fmmpcrtid       varchar2(20)      ,/* 資料建立者 */
fmmpcrtdp       varchar2(10)      ,/* 資料建立部門 */
fmmpcrtdt       timestamp(0)      ,/* 資料創建日 */
fmmpmodid       varchar2(20)      ,/* 資料修改者 */
fmmpmoddt       timestamp(0)      ,/* 最近修改日 */
fmmpcnfid       varchar2(20)      ,/* 資料確認者 */
fmmpcnfdt       timestamp(0)      ,/* 資料確認日 */
fmmppstid       varchar2(20)      ,/* 資料過帳者 */
fmmppstdt       timestamp(0)      ,/* 資料過帳日 */
fmmpstus       varchar2(10)      ,/* 狀態碼 */
fmmpud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fmmpud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fmmpud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fmmpud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fmmpud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fmmpud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fmmpud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fmmpud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fmmpud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fmmpud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fmmpud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fmmpud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fmmpud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fmmpud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fmmpud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fmmpud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fmmpud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fmmpud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fmmpud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fmmpud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fmmpud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fmmpud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fmmpud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fmmpud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fmmpud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fmmpud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fmmpud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fmmpud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fmmpud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fmmpud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
fmmp010       number(20,10)      ,/* 匯率 */
fmmp011       number(20,6)      /* 期末公允價值本幣金額 */
);
alter table fmmp_t add constraint fmmp_pk primary key (fmmpent,fmmpld,fmmp001,fmmp002,fmmp004) enable validate;

create unique index fmmp_pk on fmmp_t (fmmpent,fmmpld,fmmp001,fmmp002,fmmp004);

grant select on fmmp_t to tiptop;
grant update on fmmp_t to tiptop;
grant delete on fmmp_t to tiptop;
grant insert on fmmp_t to tiptop;

exit;
