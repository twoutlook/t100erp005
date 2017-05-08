/* 
================================================================================
檔案代號:prbk_t
檔案名稱:調價清單資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table prbk_t
(
prbkent       number(5)      ,/* 企業編號 */
prbkunit       varchar2(10)      ,/* 應用組織 */
prbksite       varchar2(10)      ,/* 營運據點 */
prbk001       varchar2(20)      ,/* 單據編號 */
prbk002       number(10,0)      ,/* 項次 */
prbk003       varchar2(10)      ,/* 單據類型 */
prbk004       varchar2(10)      ,/* 供應商 */
prbk005       varchar2(10)      ,/* 管理品類 */
prbk006       date      ,/* 開始日期 */
prbk007       date      ,/* 截止日期 */
prbk008       varchar2(8)      ,/* No use */
prbk009       varchar2(8)      ,/* No use */
prbk010       varchar2(40)      ,/* 商品編號 */
prbk011       varchar2(40)      ,/* 商品條碼 */
prbk012       varchar2(256)      ,/* 商品特征 */
prbk013       varchar2(10)      ,/* PLU碼 */
prbk014       varchar2(10)      ,/* 單位編號 */
prbk015       number(20,6)      ,/* 整包件數 */
prbk016       number(5,0)      ,/* 價格因子 */
prbk017       varchar2(10)      ,/* 進項稅別 */
prbk018       number(20,6)      ,/* 進價 */
prbk019       varchar2(10)      ,/* 銷項稅別 */
prbk020       number(20,6)      ,/* 售價 */
prbk021       number(20,6)      ,/* 會員價1 */
prbk022       number(20,6)      ,/* 會員價2 */
prbk023       number(20,6)      ,/* 會員價3 */
prbk024       timestamp(0)      ,/* 確認日期時間 */
prbkstus       varchar2(10)      ,/* 狀態 */
prbk025       varchar2(10)      ,/* 調價類型 */
prbk026       varchar2(20)      ,/* 制單者 */
prbk027       varchar2(20)      ,/* 稽覈者 */
prbkud001       varchar2(40)      ,/* 活動類型 */
prbkud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prbkud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prbkud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prbkud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prbkud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prbkud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prbkud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prbkud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prbkud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prbkud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prbkud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prbkud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prbkud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prbkud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prbkud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prbkud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prbkud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prbkud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prbkud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prbkud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prbkud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prbkud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prbkud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prbkud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prbkud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prbkud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prbkud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prbkud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prbkud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table prbk_t add constraint prbk_pk primary key (prbkent,prbksite,prbk001,prbk002,prbk006,prbk025) enable validate;

create unique index prbk_pk on prbk_t (prbkent,prbksite,prbk001,prbk002,prbk006,prbk025);

grant select on prbk_t to tiptop;
grant update on prbk_t to tiptop;
grant delete on prbk_t to tiptop;
grant insert on prbk_t to tiptop;

exit;
