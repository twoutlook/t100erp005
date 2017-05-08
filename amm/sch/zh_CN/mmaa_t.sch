/* 
================================================================================
檔案代號:mmaa_t
檔案名稱:會員基本資料申請檔-主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table mmaa_t
(
mmaaent       number(5)      ,/* 企業編號 */
mmaaunit       varchar2(10)      ,/* 應用組織 */
mmaasite       varchar2(10)      ,/* 營運據點 */
mmaa000       varchar2(10)      ,/* 申請類別 */
mmaadocno       varchar2(20)      ,/* 單據編號 */
mmaadocdt       date      ,/* 申請日期 */
mmaa001       varchar2(30)      ,/* 會員編號 */
mmaa002       varchar2(10)      ,/* 版本 */
mmaa003       varchar2(10)      ,/* 證件種類 */
mmaa004       varchar2(20)      ,/* 證件號碼 */
mmaa005       varchar2(80)      ,/* 會員姓名-姓氏 */
mmaa006       varchar2(80)      ,/* 會員姓名-中間名 */
mmaa007       varchar2(80)      ,/* 會員姓名-名字 */
mmaa008       varchar2(255)      ,/* 會員姓名 */
mmaa009       varchar2(80)      ,/* 會員暱稱 */
mmaa010       varchar2(12)      ,/* 會員郵遞區號 */
mmaa011       varchar2(4000)      ,/* 會員地址 */
mmaa012       varchar2(80)      ,/* 會員E-mail */
mmaa013       varchar2(20)      ,/* 會員電話號碼 */
mmaa014       varchar2(20)      ,/* 會員手機號碼 */
mmaa015       date      ,/* 會員出生日期 */
mmaa016       varchar2(10)      ,/* 大宗客戶編號 */
mmaa017       varchar2(10)      ,/* 員購員工編號 */
mmaa018       varchar2(10)      ,/* no use */
mmaa019       varchar2(20)      ,/* 申請人員 */
mmaaacti       varchar2(10)      ,/* 資料有效碼 */
mmaastus       varchar2(10)      ,/* 狀態碼 */
mmaaownid       varchar2(20)      ,/* 資料所屬者 */
mmaaowndp       varchar2(10)      ,/* 資料所屬部門 */
mmaacrtid       varchar2(20)      ,/* 資料建立者 */
mmaacrtdp       varchar2(10)      ,/* 資料建立部門 */
mmaacrtdt       timestamp(0)      ,/* 資料創建日 */
mmaamodid       varchar2(20)      ,/* 資料修改者 */
mmaamoddt       timestamp(0)      ,/* 最近修改日 */
mmaacnfid       varchar2(20)      ,/* 資料確認者 */
mmaacnfdt       timestamp(0)      ,/* 資料確認日 */
mmaaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmaaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmaaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmaaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmaaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmaaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmaaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmaaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmaaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmaaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmaaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmaaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmaaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmaaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmaaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmaaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmaaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmaaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmaaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmaaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmaaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmaaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmaaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmaaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmaaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmaaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmaaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmaaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmaaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmaaud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
mmaa020       varchar2(30)      ,/* 會員卡號 */
mmaa023       varchar2(10)      /* 電子發票中獎通知方式 */
);
alter table mmaa_t add constraint mmaa_pk primary key (mmaaent,mmaadocno) enable validate;

create  index mmaa_01 on mmaa_t (mmaa001);
create  index mmaa_02 on mmaa_t (mmaa013);
create  index mmaa_03 on mmaa_t (mmaa014);
create  index mmaa_04 on mmaa_t (mmaa015);
create unique index mmaa_pk on mmaa_t (mmaaent,mmaadocno);

grant select on mmaa_t to tiptop;
grant update on mmaa_t to tiptop;
grant delete on mmaa_t to tiptop;
grant insert on mmaa_t to tiptop;

exit;
