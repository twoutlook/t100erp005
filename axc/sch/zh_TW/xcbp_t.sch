/* 
================================================================================
檔案代號:xcbp_t
檔案名稱:聯產品期分配比例設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xcbp_t
(
xcbpent       number(5)      ,/* 企業編號 */
xcbpsite       varchar2(10)      ,/* 營運據點 */
xcbp001       number(5,0)      ,/* 年度 */
xcbp002       number(5,0)      ,/* 期別 */
xcbp003       varchar2(40)      ,/* 主件料號 */
xcbp004       varchar2(40)      ,/* 聯產品料號 */
xcbp005       varchar2(10)      ,/* 聯產品單位 */
xcbp006       number(20,6)      ,/* 分配率 */
xcbpownid       varchar2(20)      ,/* 資料所有者 */
xcbpowndp       varchar2(10)      ,/* 資料所屬部門 */
xcbpcrtid       varchar2(20)      ,/* 資料建立者 */
xcbpcrtdp       varchar2(10)      ,/* 資料建立部門 */
xcbpcrtdt       timestamp(0)      ,/* 資料創建日 */
xcbpmodid       varchar2(20)      ,/* 資料修改者 */
xcbpmoddt       timestamp(0)      ,/* 最近修改日 */
xcbpstus       varchar2(10)      ,/* 狀態碼 */
xcbpud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xcbpud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xcbpud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xcbpud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xcbpud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xcbpud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xcbpud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xcbpud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xcbpud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xcbpud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xcbpud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xcbpud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xcbpud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xcbpud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xcbpud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xcbpud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xcbpud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xcbpud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xcbpud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xcbpud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xcbpud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xcbpud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xcbpud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xcbpud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xcbpud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xcbpud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xcbpud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xcbpud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xcbpud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xcbpud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xcbp_t add constraint xcbp_pk primary key (xcbpent,xcbpsite,xcbp001,xcbp002,xcbp003,xcbp004) enable validate;

create unique index xcbp_pk on xcbp_t (xcbpent,xcbpsite,xcbp001,xcbp002,xcbp003,xcbp004);

grant select on xcbp_t to tiptop;
grant update on xcbp_t to tiptop;
grant delete on xcbp_t to tiptop;
grant insert on xcbp_t to tiptop;

exit;
