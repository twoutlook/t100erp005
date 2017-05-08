/* 
================================================================================
檔案代號:nmbo_t
檔案名稱:內部資金排程撥出明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table nmbo_t
(
nmboent       number(5)      ,/* 企業編碼 */
nmbodocno       varchar2(20)      ,/* 調度單號 */
nmboseq       number(10,0)      ,/* 序號 */
nmboseq2       varchar2(10)      ,/* 手續費序號 */
nmbo001       varchar2(10)      ,/* 組織代碼 */
nmbo002       varchar2(10)      ,/* 調度項目 */
nmbo003       varchar2(15)      ,/* 開戶銀行 */
nmbo004       varchar2(10)      ,/* 交易帳戶 */
nmbo005       varchar2(10)      ,/* 內部帳戶 */
nmbo006       varchar2(10)      ,/* 幣別 */
nmbo007       number(20,10)      ,/* 匯率 */
nmbo008       number(20,6)      ,/* 原幣金額 */
nmbo009       number(20,6)      ,/* 本幣金額 */
nmbo010       varchar2(10)      ,/* 存提碼 */
nmbo011       varchar2(10)      ,/* 現金變動碼 */
nmbo012       date      ,/* 出帳日期 */
nmbo013       varchar2(20)      ,/* 主帳套帳務單號 */
nmbo014       number(5,3)      ,/* 年利率 */
nmbo015       number(20,6)      ,/* 手續費原幣 */
nmbo016       number(20,6)      ,/* 手續費本幣 */
nmbo017       varchar2(10)      ,/* 手續費存提碼 */
nmbo018       varchar2(10)      ,/* 手續費現金變動碼 */
nmbo019       number(20,6)      ,/* 累積利息 */
nmbo020       number(20,6)      ,/* 已還原幣金額 */
nmbo021       varchar2(1)      ,/* 結案否 */
nmbo022       date      ,/* 結案日期 */
nmbo023       varchar2(20)      ,/* 次帳一帳務單號 */
nmbo024       varchar2(20)      ,/* 次帳二帳務單號 */
nmbo025       varchar2(10)      ,/* 內部交易對象 */
nmboud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
nmboud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
nmboud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
nmboud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
nmboud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
nmboud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
nmboud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
nmboud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
nmboud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
nmboud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
nmboud011       number(20,6)      ,/* 自定義欄位(數字)011 */
nmboud012       number(20,6)      ,/* 自定義欄位(數字)012 */
nmboud013       number(20,6)      ,/* 自定義欄位(數字)013 */
nmboud014       number(20,6)      ,/* 自定義欄位(數字)014 */
nmboud015       number(20,6)      ,/* 自定義欄位(數字)015 */
nmboud016       number(20,6)      ,/* 自定義欄位(數字)016 */
nmboud017       number(20,6)      ,/* 自定義欄位(數字)017 */
nmboud018       number(20,6)      ,/* 自定義欄位(數字)018 */
nmboud019       number(20,6)      ,/* 自定義欄位(數字)019 */
nmboud020       number(20,6)      ,/* 自定義欄位(數字)020 */
nmboud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
nmboud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
nmboud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
nmboud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
nmboud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
nmboud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
nmboud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
nmboud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
nmboud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
nmboud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table nmbo_t add constraint nmbo_pk primary key (nmboent,nmbodocno,nmboseq2) enable validate;

create unique index nmbo_pk on nmbo_t (nmboent,nmbodocno,nmboseq2);

grant select on nmbo_t to tiptop;
grant update on nmbo_t to tiptop;
grant delete on nmbo_t to tiptop;
grant insert on nmbo_t to tiptop;

exit;
