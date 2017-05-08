/* 
================================================================================
檔案代號:xcbd_t
檔案名稱:聯產品分配設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xcbd_t
(
xcbdent       number(5)      ,/* 企業編號 */
xcbdownid       varchar2(20)      ,/* 資料所有者 */
xcbdowndp       varchar2(10)      ,/* 資料所屬部門 */
xcbdcrtid       varchar2(20)      ,/* 資料建立者 */
xcbdcrtdp       varchar2(10)      ,/* 資料建立部門 */
xcbdcrtdt       timestamp(0)      ,/* 資料創建日 */
xcbdmodid       varchar2(20)      ,/* 資料修改者 */
xcbdmoddt       timestamp(0)      ,/* 最近修改日 */
xcbdsite       varchar2(10)      ,/* 營運據點 */
xcbd001       varchar2(40)      ,/* 主件料號 */
xcbd002       number(5,0)      ,/* 年度 */
xcbd003       number(5,0)      ,/* 期別 */
xcbd004       varchar2(40)      ,/* 聯產品料號 */
xcbd005       varchar2(10)      ,/* 聯產品單位 */
xcbd006       number(20,6)      ,/* 分配率 */
xcbdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xcbdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xcbdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xcbdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xcbdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xcbdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xcbdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xcbdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xcbdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xcbdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xcbdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xcbdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xcbdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xcbdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xcbdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xcbdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xcbdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xcbdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xcbdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xcbdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xcbdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xcbdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xcbdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xcbdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xcbdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xcbdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xcbdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xcbdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xcbdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xcbdud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xcbd_t add constraint xcbd_pk primary key (xcbdent,xcbdsite,xcbd001,xcbd002,xcbd003,xcbd004) enable validate;

create unique index xcbd_pk on xcbd_t (xcbdent,xcbdsite,xcbd001,xcbd002,xcbd003,xcbd004);

grant select on xcbd_t to tiptop;
grant update on xcbd_t to tiptop;
grant delete on xcbd_t to tiptop;
grant insert on xcbd_t to tiptop;

exit;
