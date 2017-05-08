/* 
================================================================================
檔案代號:stao_t
檔案名稱:自營合約費用設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stao_t
(
staoent       number(5)      ,/* 企業編號 */
stao001       varchar2(20)      ,/* 合約編號 */
stao002       number(10,0)      ,/* 項次 */
stao003       varchar2(10)      ,/* 費用編號 */
stao004       varchar2(10)      ,/* 會計期間 */
stao005       varchar2(10)      ,/* 價款類別 */
stao006       varchar2(10)      ,/* 計算類型 */
stao007       varchar2(10)      ,/* 費用週期 */
stao008       varchar2(10)      ,/* 費用週期方式 */
stao009       varchar2(10)      ,/* 條件基準 */
stao010       varchar2(10)      ,/* 計算基準 */
stao011       number(20,6)      ,/* 費用淨額 */
stao012       number(20,6)      ,/* 費用比率 */
stao013       varchar2(10)      ,/* 保底否 */
stao014       number(20,6)      ,/* 保底金額 */
stao015       number(20,6)      ,/* 保底扣率 */
stao016       varchar2(10)      ,/* 分量扣點 */
stao017       date      ,/* 生效日期 */
stao018       date      ,/* 失效日期 */
stao019       date      ,/* 下次計算日 */
staoud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
staoud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
staoud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
staoud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
staoud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
staoud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
staoud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
staoud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
staoud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
staoud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
staoud011       number(20,6)      ,/* 自定義欄位(數字)011 */
staoud012       number(20,6)      ,/* 自定義欄位(數字)012 */
staoud013       number(20,6)      ,/* 自定義欄位(數字)013 */
staoud014       number(20,6)      ,/* 自定義欄位(數字)014 */
staoud015       number(20,6)      ,/* 自定義欄位(數字)015 */
staoud016       number(20,6)      ,/* 自定義欄位(數字)016 */
staoud017       number(20,6)      ,/* 自定義欄位(數字)017 */
staoud018       number(20,6)      ,/* 自定義欄位(數字)018 */
staoud019       number(20,6)      ,/* 自定義欄位(數字)019 */
staoud020       number(20,6)      ,/* 自定義欄位(數字)020 */
staoud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
staoud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
staoud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
staoud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
staoud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
staoud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
staoud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
staoud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
staoud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
staoud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
stao020       date      ,/* 下次費用開始日 */
stao021       date      ,/* 下次費用截止日 */
stao022       varchar2(10)      ,/* 自定義範圍 */
stao023       varchar2(1)      ,/* 納入結算單否 */
stao024       varchar2(1)      ,/* 票扣否 */
stao025       varchar2(10)      ,/* 管理品類 */
stao026       varchar2(20)      ,/* 生效月份 */
stao027       varchar2(1)      ,/* 按自然月計費否 */
staoacti       varchar2(1)      ,/* 有效 */
stao028       varchar2(1)      ,/* 固定費用是否按法人收取 */
stao029       number(20,6)      ,/* 促銷扣率 */
stao030       number(20,6)      /* 促銷銷售額占比 */
);
alter table stao_t add constraint stao_pk primary key (staoent,stao001,stao002) enable validate;

create unique index stao_pk on stao_t (staoent,stao001,stao002);

grant select on stao_t to tiptop;
grant update on stao_t to tiptop;
grant delete on stao_t to tiptop;
grant insert on stao_t to tiptop;

exit;
