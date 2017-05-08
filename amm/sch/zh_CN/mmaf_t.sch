/* 
================================================================================
檔案代號:mmaf_t
檔案名稱:會員基本資料檔-主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table mmaf_t
(
mmafent       number(5)      ,/* 企業編號 */
mmafunit       varchar2(10)      ,/* 應用組織 */
mmaf001       varchar2(30)      ,/* 會員編號 */
mmaf002       varchar2(10)      ,/* 最新版本 */
mmaf003       varchar2(10)      ,/* 證件種類 */
mmaf004       varchar2(20)      ,/* 證件號碼 */
mmaf005       varchar2(80)      ,/* 會員姓名-姓氏 */
mmaf006       varchar2(80)      ,/* 會員姓名-中間名 */
mmaf007       varchar2(80)      ,/* 會員姓名-名字 */
mmaf008       varchar2(255)      ,/* 會員姓名 */
mmaf009       varchar2(80)      ,/* 會員暱稱 */
mmaf010       varchar2(12)      ,/* 會員郵遞區號 */
mmaf011       varchar2(4000)      ,/* 會員地址 */
mmaf012       varchar2(80)      ,/* 會員E-mail */
mmaf013       varchar2(20)      ,/* 會員電話號碼 */
mmaf014       varchar2(20)      ,/* 會員手機號碼 */
mmaf015       date      ,/* 會員出生日期 */
mmaf016       varchar2(10)      ,/* 大宗客戶編號 */
mmaf017       varchar2(10)      ,/* 員購員工編號 */
mmaf018       varchar2(10)      ,/* no use */
mmaf019       varchar2(20)      ,/* 申請人員 */
mmaf020       varchar2(10)      ,/* 會員價值 */
mmaf021       varchar2(10)      ,/* 會員生命週期 */
mmaf022       varchar2(10)      ,/* ABC分類 */
mmafstus       varchar2(10)      ,/* 狀態碼 */
mmafownid       varchar2(20)      ,/* 資料所有者 */
mmafowndp       varchar2(10)      ,/* 資料所屬部門 */
mmafcrtid       varchar2(20)      ,/* 資料建立者 */
mmafcrtdp       varchar2(10)      ,/* 資料建立部門 */
mmafcrtdt       timestamp(0)      ,/* 資料創建日 */
mmafmodid       varchar2(20)      ,/* 資料修改者 */
mmafmoddt       timestamp(0)      ,/* 最近修改日 */
mmafcnfid       varchar2(20)      ,/* 資料確認者 */
mmafcnfdt       timestamp(0)      ,/* 資料確認日 */
mmafud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmafud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmafud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmafud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmafud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmafud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmafud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmafud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmafud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmafud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmafud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmafud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmafud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmafud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmafud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmafud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmafud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmafud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmafud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmafud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmafud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmafud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmafud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmafud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmafud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmafud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmafud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmafud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmafud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmafud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
mmaf023       varchar2(10)      /* 電子發票中獎通知方式 */
);
alter table mmaf_t add constraint mmaf_pk primary key (mmafent,mmaf001) enable validate;

create  index mmaf_01 on mmaf_t (mmaf013);
create  index mmaf_02 on mmaf_t (mmaf014);
create  index mmaf_03 on mmaf_t (mmaf015);
create  index mmaf_04 on mmaf_t (mmaf004);
create unique index mmaf_pk on mmaf_t (mmafent,mmaf001);

grant select on mmaf_t to tiptop;
grant update on mmaf_t to tiptop;
grant delete on mmaf_t to tiptop;
grant insert on mmaf_t to tiptop;

exit;
