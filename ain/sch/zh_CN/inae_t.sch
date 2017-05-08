/* 
================================================================================
檔案代號:inae_t
檔案名稱:料件製造批序號資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table inae_t
(
inaeent       number(5)      ,/* 企業編號 */
inae001       varchar2(40)      ,/* 料件編號 */
inaesite       varchar2(10)      ,/* 營運據點 */
inae002       varchar2(256)      ,/* 產品特徵 */
inae003       varchar2(30)      ,/* 製造批號 */
inae004       varchar2(30)      ,/* 製造序號 */
inae005       varchar2(20)      ,/* 來源單號 */
inae006       number(10,0)      ,/* 來源項次 */
inae007       number(10,0)      ,/* 來源項序 */
inae008       varchar2(10)      ,/* 部門編號 */
inae009       varchar2(10)      ,/* 交易對象編號 */
inae010       date      ,/* 製造日期 */
inae011       date      ,/* 有效日期 */
inae030       varchar2(255)      ,/* 備註 */
inaeownid       varchar2(20)      ,/* 資料所有者 */
inaeowndp       varchar2(10)      ,/* 資料所屬部門 */
inaecrtid       varchar2(20)      ,/* 資料建立者 */
inaecrtdp       varchar2(10)      ,/* 資料建立部門 */
inaecrtdt       timestamp(0)      ,/* 資料創建日 */
inaemodid       varchar2(20)      ,/* 資料修改者 */
inaemoddt       timestamp(0)      ,/* 最近修改日 */
inaestus       varchar2(10)      ,/* 狀態碼 */
inaeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
inaeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
inaeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
inaeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
inaeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
inaeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
inaeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
inaeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
inaeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
inaeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
inaeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
inaeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
inaeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
inaeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
inaeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
inaeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
inaeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
inaeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
inaeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
inaeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
inaeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
inaeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
inaeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
inaeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
inaeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
inaeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
inaeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
inaeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
inaeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
inaeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table inae_t add constraint inae_pk primary key (inaeent,inae001,inaesite,inae002,inae003,inae004) enable validate;

create unique index inae_pk on inae_t (inaeent,inae001,inaesite,inae002,inae003,inae004);

grant select on inae_t to tiptop;
grant update on inae_t to tiptop;
grant delete on inae_t to tiptop;
grant insert on inae_t to tiptop;

exit;
