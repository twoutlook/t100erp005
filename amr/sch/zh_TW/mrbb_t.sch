/* 
================================================================================
檔案代號:mrbb_t
檔案名稱:資源保養校正週期設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table mrbb_t
(
mrbbent       number(5)      ,/* 企業編號 */
mrbbsite       varchar2(10)      ,/* 營運據點 */
mrbb001       varchar2(20)      ,/* 資源編號 */
mrbb002       number(10,0)      ,/* 項次 */
mrbb003       varchar2(10)      ,/* 保修類型 */
mrbb004       varchar2(10)      ,/* 保修週期 */
mrbb005       varchar2(10)      ,/* 檢驗單位區分 */
mrbb006       varchar2(10)      ,/* 執行單位/廠商 */
mrbb007       date      ,/* 最近保養日期 */
mrbb008       date      ,/* 下次保養日期 */
mrbb009       varchar2(8)      ,/* 預計時間 */
mrbb010       varchar2(10)      ,/* 時間單位 */
mrbb011       number(10,0)      ,/* 提前通知天數 */
mrbb012       varchar2(20)      ,/* 通知人員 */
mrbb013       varchar2(1)      ,/* 停機保養 */
mrbbstus       varchar2(10)      ,/* 資料狀態碼 */
mrbbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mrbbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mrbbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mrbbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mrbbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mrbbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mrbbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mrbbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mrbbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mrbbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mrbbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mrbbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mrbbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mrbbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mrbbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mrbbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mrbbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mrbbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mrbbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mrbbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mrbbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mrbbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mrbbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mrbbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mrbbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mrbbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mrbbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mrbbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mrbbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mrbbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mrbb_t add constraint mrbb_pk primary key (mrbbent,mrbbsite,mrbb001,mrbb002) enable validate;

create  index mrbb_01 on mrbb_t (mrbb003);
create unique index mrbb_pk on mrbb_t (mrbbent,mrbbsite,mrbb001,mrbb002);

grant select on mrbb_t to tiptop;
grant update on mrbb_t to tiptop;
grant delete on mrbb_t to tiptop;
grant insert on mrbb_t to tiptop;

exit;
