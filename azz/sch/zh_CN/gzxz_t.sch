/* 
================================================================================
檔案代號:gzxz_t
檔案名稱:使用者計數檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table gzxz_t
(
gzxzent       number(5)      ,/* 企業編號 */
gzxz001       varchar2(20)      ,/* 使用者編號 */
gzxz002       date      ,/* 上次密碼更新時間 */
gzxz003       number(5,0)      ,/* 密碼已用次數 */
gzxz004       varchar2(1)      ,/* 強制使用者於下次登入更改密碼 */
gzxz005       date      ,/* 用戶可用起始日期 */
gzxz006       date      ,/* 用戶可用截止日期 */
gzxz007       number(5,0)      ,/* 累計登入錯誤次數(成功登入後清空) */
gzxz008       number(10,0)      ,/* 累計成功登入次數 */
gzxz009       date      ,/* 上次成功登入日期時間 */
gzxz010       varchar2(20)      ,/* 上次成功登入IP */
gzxzud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzxzud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzxzud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzxzud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzxzud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzxzud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzxzud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzxzud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzxzud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzxzud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzxzud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzxzud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzxzud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzxzud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzxzud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzxzud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzxzud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzxzud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzxzud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzxzud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzxzud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzxzud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzxzud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzxzud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzxzud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzxzud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzxzud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzxzud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzxzud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzxzud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gzxz_t add constraint gzxz_pk primary key (gzxzent,gzxz001) enable validate;

create unique index gzxz_pk on gzxz_t (gzxzent,gzxz001);

grant select on gzxz_t to tiptop;
grant update on gzxz_t to tiptop;
grant delete on gzxz_t to tiptop;
grant insert on gzxz_t to tiptop;

exit;
