/* 
================================================================================
檔案代號:fmmu_t
檔案名稱:計提收益帳務單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table fmmu_t
(
fmmuent       number(5)      ,/* 企業編號 */
fmmudocno       varchar2(20)      ,/* 公允價值調整帳務單號 */
fmmusite       varchar2(10)      ,/* 帳務中心 */
fmmu001       varchar2(5)      ,/* 帳套 */
fmmu002       number(5,0)      ,/* 年度 */
fmmu003       number(5,0)      ,/* 期別 */
fmmu004       varchar2(20)      ,/* 傳票編號 */
fmmudocdt       date      ,/* 單據日期 */
fmmuownid       varchar2(20)      ,/* 資料所有者 */
fmmuowndp       varchar2(10)      ,/* 資料所屬部門 */
fmmucrtid       varchar2(20)      ,/* 資料建立者 */
fmmucrtdp       varchar2(10)      ,/* 資料建立部門 */
fmmucrtdt       timestamp(0)      ,/* 資料創建日 */
fmmumodid       varchar2(20)      ,/* 資料修改者 */
fmmumoddt       timestamp(0)      ,/* 最近修改日 */
fmmucnfid       varchar2(20)      ,/* 資料確認者 */
fmmucnfdt       timestamp(0)      ,/* 資料確認日 */
fmmupstid       varchar2(20)      ,/* 資料過帳者 */
fmmupstdt       timestamp(0)      ,/* 資料過帳日 */
fmmustus       varchar2(10)      ,/* 狀態碼 */
fmmuud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fmmuud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fmmuud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fmmuud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fmmuud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fmmuud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fmmuud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fmmuud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fmmuud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fmmuud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fmmuud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fmmuud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fmmuud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fmmuud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fmmuud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fmmuud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fmmuud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fmmuud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fmmuud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fmmuud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fmmuud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fmmuud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fmmuud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fmmuud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fmmuud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fmmuud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fmmuud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fmmuud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fmmuud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fmmuud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table fmmu_t add constraint fmmu_pk primary key (fmmuent,fmmudocno) enable validate;

create unique index fmmu_pk on fmmu_t (fmmuent,fmmudocno);

grant select on fmmu_t to tiptop;
grant update on fmmu_t to tiptop;
grant delete on fmmu_t to tiptop;
grant insert on fmmu_t to tiptop;

exit;
