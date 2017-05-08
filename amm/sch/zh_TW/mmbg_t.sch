/* 
================================================================================
檔案代號:mmbg_t
檔案名稱:會員卡資料開帳單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mmbg_t
(
mmbgent       number(5)      ,/* 企業編號 */
mmbgunit       varchar2(10)      ,/* 應用組織 */
mmbgsite       varchar2(10)      ,/* 營運據點 */
mmbgdocno       varchar2(20)      ,/* 單號 */
mmbg001       varchar2(30)      ,/* 會員卡號 */
mmbg002       varchar2(10)      ,/* 卡種編號 */
mmbg003       varchar2(30)      ,/* 會員編號 */
mmbg004       varchar2(10)      ,/* 會員卡密碼 */
mmbg005       date      ,/* 會員卡有效期 */
mmbg006       varchar2(1)      ,/* 會員卡狀態 */
mmbg007       varchar2(1)      ,/* 會員卡可儲值 */
mmbg008       number(5,0)      ,/* 會員卡儲值折扣 */
mmbg009       number(20,6)      ,/* 會員卡儲值餘額 */
mmbg010       number(20,6)      ,/* 累計儲值折扣金額 */
mmbg011       number(20,6)      ,/* 累計加值金額 */
mmbg012       number(20,6)      ,/* 累計送抵現值金額 */
mmbg013       date      ,/* 最後消費日 */
mmbg014       number(5,0)      ,/* 累計消費次數 */
mmbg015       number(20,6)      ,/* 累計消費金額 */
mmbg016       number(15,3)      ,/* 累計積點 */
mmbg017       number(15,3)      ,/* 已兌換積點 */
mmbg018       number(15,3)      ,/* 剩餘積點 */
mmbg019       date      ,/* 最後積點清零日 */
mmbg020       varchar2(10)      ,/* 製卡營運據點 */
mmbg021       date      ,/* 製卡日期 */
mmbg022       varchar2(10)      ,/* 髮卡營運據點 */
mmbg023       date      ,/* 髮卡日期 */
mmbg024       varchar2(10)      ,/* 開卡營運據點 */
mmbg025       date      ,/* 開卡日期 */
mmbg026       varchar2(10)      ,/* 作廢營運據點 */
mmbg027       date      ,/* 作廢日期 */
mmbg028       varchar2(10)      ,/* 註銷營運據點 */
mmbg029       date      ,/* 註銷日期 */
mmbg030       varchar2(10)      ,/* 掛失營運據點 */
mmbg031       date      ,/* 掛失日期 */
mmbg032       number(20,6)      ,/* 累計儲值成本 */
mmbg039       varchar2(10)      ,/* 存放位置 */
mmbgud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmbgud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmbgud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmbgud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmbgud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmbgud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmbgud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmbgud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmbgud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmbgud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmbgud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmbgud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmbgud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmbgud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmbgud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmbgud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmbgud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmbgud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmbgud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmbgud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmbgud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmbgud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmbgud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmbgud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmbgud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmbgud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmbgud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmbgud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmbgud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmbgud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmbg_t add constraint mmbg_pk primary key (mmbgent,mmbgdocno,mmbg001) enable validate;

create unique index mmbg_pk on mmbg_t (mmbgent,mmbgdocno,mmbg001);

grant select on mmbg_t to tiptop;
grant update on mmbg_t to tiptop;
grant delete on mmbg_t to tiptop;
grant insert on mmbg_t to tiptop;

exit;
